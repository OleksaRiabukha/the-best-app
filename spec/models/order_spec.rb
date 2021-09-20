# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  appartment_number :integer
#  building          :string           not null
#  city              :string           not null
#  pay_type          :integer          not null
#  payment_status    :integer
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
  let(:cart) { create(:cart) }
  let(:cart_item) { create(:cart_item) }
  let(:order) { create(:order) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:building) }
    it { is_expected.to define_enum_for(:pay_type).with_values(%w[Card Cash]) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:geocoded_address) }
  end

  describe 'addition of cart items to order' do
    it 'adds items from the cart to order and transfers total price of cart items' do
      cart.cart_items << cart_item
      order.add_cart_items_from_cart(cart)
      expect(order.cart_items.last.id).to eq(cart_item.id)
      expect(order.total_price).to eq(cart.total_cart_price)
    end
  end

  describe 'payment status' do
    let(:user) { create(:user) }
    let(:card_order) { create(:order, user: user, pay_type: 'Card') }
    let(:cash_order) { create(:order, user: user, pay_type: 'Cash') }

    it 'sets status to "pending_card_payment" if user opts for paying with card' do
      expect(card_order.payment_status).to eq('pending_card_payment')
    end

    it 'sets status to "pending_cash_payment" if user opts for paying with cash' do
      expect(cash_order.payment_status).to eq('pending_cash_payment')
    end
  end

  describe 'interaction with stripe webhook' do
    let(:event) { StripeMock.mock_webhook_event('charge.succeeded') }
    let(:payment_object) { event.data.object }

    it 'adds stripe payment id to order upon successful charging' do
      order.add_stripe_payment_id(payment_object.id)
      expect(order.stripe_payment_id).to eq(payment_object.id)
    end

    it 'changes payment status of order to paid' do
      order.paid
      expect(order.payment_status).to eq('paid')
    end
  end

  describe 'adding geocoded addresses' do
    it 'adds a geocoded address of the orders address with longitude and latitude' do
      GeocoderStub.stub(order.city, order.street, order.building)
      order.geocode_address

      expect(order.geocoded_address).not_to be_nil
      expect(order.geocoded_address.longitude).not_to be_nil
      expect(order.geocoded_address.latitude).not_to be_nil
    end
  end
end
