class AddDiscountToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :discount, :decimal, precision: 8, scale: 2
  end
end
