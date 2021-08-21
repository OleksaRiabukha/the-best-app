# == Schema Information
#
# Table name: cart_items
#
#  id           :bigint           not null, primary key
#  quantity     :integer          default(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cart_id      :bigint           not null
#  menu_item_id :bigint           not null
#
# Indexes
#
#  index_cart_items_on_cart_id       (cart_id)
#  index_cart_items_on_menu_item_id  (menu_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (menu_item_id => menu_items.id)
#
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :menu_item

  def total_price
    menu_item.price * quantity
  end
end
