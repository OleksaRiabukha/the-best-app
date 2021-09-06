class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :pay_type, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :building, null: false
      t.integer :appartment_number
      t.decimal :total_price

      t.timestamps
    end
  end
end
