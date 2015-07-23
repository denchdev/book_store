class Author < ActiveRecord::Base
  has_many :books

  validates_presence_of :firstname, :lastname
  
  def full_name
    firstname + " " + lastname
  end

  def number_of_books
    Book.where(author_id: self.id).count
  end
end
