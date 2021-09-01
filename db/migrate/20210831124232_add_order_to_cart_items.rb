class AddOrderToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :cart_items, :order, null: true, foreign_key: true
    change_column :cart_items, :cart_id, :integer, null: true
  end
end
