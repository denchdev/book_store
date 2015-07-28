class Order < ActiveRecord::Base
  STATES = %w(in\ progres complited shipped)
  #STATES = %w(in_progress in_queue in_delivery delivered)

  belongs_to :customer
  belongs_to :credit_card, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :billing_address,  class_name: "Address", foreign_key: "billing_address_id"
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address_id"
  
  validates_presence_of :total_price, :state
  validates_presence_of :completed_date
  validates :state, inclusion: { in: STATES, message: "%{value} is not a valid value" }

  before_save :total

  scope :in_progress, -> {where(state: STATES[0])}
 
  
end
