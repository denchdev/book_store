class Order < ActiveRecord::Base
  STATES = %w(in\ progres complited shipped)
  #STATES = %w(in_progress in_queue in_delivery delivered)

  belongs_to :customer
  belongs_to :credit_card, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :billing_address,  class_name: "Address", foreign_key: "billing_address_id"
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address_id"
  
  validates_presence_of :total_price, :state
  validates_presence_of :completed_date, if: -> {self.state == STATES[1]}
  validates :state, inclusion: { in: STATES, message: "%{value} is not a valid value" }

  before_save :total

  scope :in_progress, -> {where(state: STATES[0])}
  #####
  #validates :checkout_step, inclusion: { in: 1..5 }
  
  state_machine :state, :initial => :in_progress do
    after_transition :on => :complete, :do => :complete!

    event :checkout do
      transition :in_progress => :in_queue
    end

    event :proceed do
      transition :in_queue => :in_delivery
    end

    event :complete do
      transition :in_delivery => :delivered
    end
  end
  ##########
  
  
  def total
    self.total_price = self.order_items.find_in_batches do |items|
      items.inject(0) {|sum, item| sum + item.price * item.quantity}
    end
  end
  
  def add_book book, quantity = 1
    book = Books.find book if book is_a? Numeric
    order_item = OrderItem.find_by(book_id: book.id)
    if order_item.nil?
      self.order_items << OrderItem.new(price: book.price, book_id: book.id, quantity: quantity)
    else
      item_quantity = order_item.quantity
      item_quantity += amount
      order_item.update_attributes(quantity: item_quantity)
    end
  end
  
  def to_queue!(customer)
    self.order_items.each do |item|
      book = Book.find(item.book_id)
      book.in_stock -= item.quantity
      book.save
    end
    self.update(customer_id: customer.id, state: 'in_queue', price: self.total_price)
  end

  def complete!
    self.completed_at = Date.today
    save
  end

  def next_step!
    self.checkout_step += 1
    save
  end

  def set_step!(value)
    self.checkout_step = value
    self.save
  end

  def self.delete_abandoned!
    Order.where(state: 'in_progress').each do |order|
      if order.updated_at < 5.hours.ago
        order.destroy
      end
    end
  end
  
end
