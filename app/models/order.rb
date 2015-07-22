class Order < ActiveRecord::Base
  STATES = %w(in\ progres complited shipped)

  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items
  belongs_to :billing_address,  class_name: "Address", foreign_key: "billing_address_id"
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address_id"
  
  validates_presence_of :total_price, :state
  validates_presence_of :completed_date, if: -> {self.state == STATES[1]}
  validates :state, inclusion: { in: STATES, message: "%{value} is not a valid value" }

  before_save :total

  scope :in_progress, -> {where(state: STATES[0])}
  
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
  
end
