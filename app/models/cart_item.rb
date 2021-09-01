# == Schema Information
#
# Table name: cart_items
#
#  id           :bigint           not null, primary key
#  price        :decimal(8, )     not null
#  quantity     :integer          default(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cart_id      :integer
#  menu_item_id :bigint           not null
#  order_id     :bigint
#
# Indexes
#
#  index_cart_items_on_cart_id       (cart_id)
#  index_cart_items_on_menu_item_id  (menu_item_id)
#  index_cart_items_on_order_id      (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (menu_item_id => menu_items.id)
#  fk_rails_...  (order_id => orders.id)
#
class CartItem < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :cart, optional: true
  belongs_to :menu_item
  belongs_to :order, optional: true

  def total_price
    price * quantity
  end

  def check_quantity
    if quantity > 1
      q = quantity - 1
      update(quantity: q)
    else
      destroy
    end
  end
end