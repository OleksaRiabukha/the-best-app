class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :menu_item, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.decimal :price, precision: 8, scal: 2, null: false
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
