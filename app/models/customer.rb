class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings  
  #has_many :books, through: ratings

  validates_presence_of :firstname, :lastname, :email, :password
  validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def new_order
    self.orders.create
  end

  def current_order
    self.orders.in_progress.last
  end
end
