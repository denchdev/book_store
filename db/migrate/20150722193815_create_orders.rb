class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 6, scale: 2, null: 0.0
      t.datetime :completed_date
      t.string :state
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :credit_card, index: true, foreign_key: true
      t.belongs_to :billing_address, index: true
      t.belongs_to :shipping_address, index: true
      t.integer :checkout_step, default: 1

      t.timestamps null: false
    end
  end
end
