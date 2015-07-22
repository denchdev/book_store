class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  has_many :ratings
  
#  has_many :customers, :throught :ratings

  validates_presence_of :title, :price, :stock
end
