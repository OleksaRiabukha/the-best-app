# == Schema Information
#
# Table name: cart_items
#
#  id           :bigint           not null, primary key
#  price        :decimal(8, )     not null
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
  default_scope { order(created_at: :desc) }

  belongs_to :cart
  belongs_to :menu_item

  def total_price
    price * quantity
  end

  def minus_one
    q = quantity - 1
    update(quantity: q)
  end
end
