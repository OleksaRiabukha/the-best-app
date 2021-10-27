require 'rails_helper'

RSpec.describe 'Webhooks', type: :request do
  let(:user) { create(:user) }
  let(:payment_succeeded) { 'payment_intent.succeeded' }
  let(:customer) { user.stripe_customer_id }
  let(:header) { StripeWebhookHeader.generate_request_header(event) }

  describe 'when stripe sends payment_intent.succedeed event for order purchase' do
    let(:order) { create(:order, pay_type: 'Card') }
    let(:metadata) { { payment_for: 'order' } }
    let(:event) { StripeMock.mock_webhook_event(payment_succeeded, customer: customer, metadata: metadata) }

    before do
      user.orders << order
      post webhooks_path, params: event.to_s, headers: { 'HTTP_STRIPE_SIGNATURE': header }
    end

    it 'changes order payment status to "paid"' do
      expect(user.orders.first.payment_status.to_sym).to eq(Order::PAID)
    end

    it 'adds stripe payment id to order' do
      expect(user.orders.first.stripe_payment_id).to be_present
      expect(user.orders.first.stripe_payment_id).to eq(event.data.object.id)
    end
  end

  describe 'when stripe sends payment_intent.succedded event for couponl purchase' do
    let(:coupon_params) { attributes_for(:coupon, :coupon_params_for_request) }
    let(:model) { { amount: coupon_params[:amount], for_present: coupon_params[:for_present] } }
    let(:metadata) { { payment_for: 'coupon', model: model } }
    let(:event) { StripeMock.mock_webhook_event(payment_succeeded, customer: customer, metadata: metadata) }

    before do
      StubbedCouponResponse.response(coupon_params)
      post webhooks_path, params: event.to_s, headers: { 'HTTP_STRIPE_SIGNATURE': header }
    end

    it 'calls external API and saves coupon to app\'s database' do
      expect(Coupon.count).to eq(1)
    end

    it 'adds coupon attributes to database' do
      coupon = Coupon.last
      expect(coupon.coupon_number).to eq(coupon_params[:coupon_number])
      expect(coupon.initial_amount.to_d).to eq(coupon_params[:amount])
      expect(coupon.amount_left).to eq(coupon_params[:amount])
      expect(coupon.for_present).to eq(coupon_params[:for_present])
    end
  end
end
