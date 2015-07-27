class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  has_many :ratings, dependent: :destroy
  
#  has_many :customers, :throught :ratings

  validates_presence_of :title, :price, :stock  
  
  mount_uploader :image, ImageUploader
end
