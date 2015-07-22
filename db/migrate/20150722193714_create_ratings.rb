class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text     :review
      t.integer  :rating
      t.integer  :customer_id
      t.integer  :book_id

      t.timestamps null: false
    end
  end
end
