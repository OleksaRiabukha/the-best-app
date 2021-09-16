# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  appartment_number :integer
#  building          :string           not null
#  city              :string           not null
#  pay_type          :integer          not null
#  street            :string           not null
#  total_price       :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_payment_id :string
#  user_id           :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:building) }
    it { is_expected.to define_enum_for(:pay_type).with_values(%w[Card Cash]) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'addition of cart items to order' do
    let(:cart) { create(:cart) }
    let(:cart_item) { create(:cart_item) }
    let(:order) { create(:order) }

    it 'adds items from the cart to order and transfers total price of cart items' do
      cart.cart_items << cart_item
      order.add_cart_items_from_cart(cart)
      expect(order.cart_items.last.id).to eq(cart_item.id)
      expect(order.total_price).to eq(cart.total_cart_price)
    end
  end
end
