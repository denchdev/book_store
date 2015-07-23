class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy  
  #has_many :books, through: ratings
  has_many :orders, 
  #has_one :customer_bill_address, class_name: 'CustomerBillAddress', dependent: :destroy
  #has_one :customer_ship_address, class_name: 'CustomerShipAddress', dependent: :destroy
  #has_many :order_items, dependent: :destroy
  

  validates_presence_of :firstname, :lastname, :email, :password
  validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def new_order
    self.orders.create
  end

  def current_order
    self.orders.in_progress.last
  end
end
