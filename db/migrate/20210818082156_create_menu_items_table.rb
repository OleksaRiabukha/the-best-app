class CreateMenuItemsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :ingredients, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.decimal :discount, precision: 8, scale: 2
      t.boolean :available, default: false

      t.timestamps
    end
  end
end
