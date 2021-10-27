class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :coupon_number, null: false
      t.decimal :initial_amount, precision: 8, scale: 2, null: false
      t.decimal :amount_left, precision: 8, scale: 2
      t.boolean :for_present
      t.belongs_to :user, foreign_key: true

      t.index :coupon_number, unique: true
      t.timestamps
    end
  end
end
