# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :user

  def add_menu_item(menu_item)
    current_item = cart_items.find_by(menu_item_id: menu_item.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(menu_item_id: menu_item.id)
    end
    current_item.price = menu_item.price
    current_item
  end

  # def remove_menu_

  def total_cart_price
    cart_items.to_a.sum(&:total_price)
  end
end
