# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:menu_item) { create(:menu_item, available: true) }
  let(:cart) { create(:cart) }
  let(:cart_items) { create_list(:cart_item, 2) }

  describe 'associations' do
    it { is_expected.to have_many(:cart_items) }
  end

  describe 'addition of a menu item to cart' do
    it 'adds menu item to cart if it is not exists there yet' do
      cart.add_menu_item(menu_item)
      expect(cart.cart_items.first.menu_item.name).to eq(menu_item.name)
    end
  end

  describe 'total price' do
    it 'sums and returns a total price of all cart items in cart' do
      cart.cart_items << cart_items
      expect(cart.total_cart_price).to eq(cart_items.sum(&:total_price))
    end
  end
end
