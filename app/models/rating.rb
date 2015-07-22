class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates_inclusion_of :rating, :in => 0..100
end
