# == Schema Information
#
# Table name: cart_items
#
#  id           :bigint           not null, primary key
#  discount     :decimal(8, 2)
#  price        :decimal(8, )     not null
#  quantity     :integer          default(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cart_id      :bigint
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
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:cart).optional }
    it { is_expected.to belong_to(:menu_item) }
  end

  describe 'total price and quantity' do
    it 'returns a total price of the cart_items' do
      expect(cart_item.total_price).to eq(cart_item.price * cart_item.quantity)
    end

    it 'reduces the quantity of cat_item by one' do
      expect do
        cart_item.check_quantity
        expect(cart_item, :quantity).be(-1)
      end
    end
  end
end
