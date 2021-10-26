require 'rails_helper'

RSpec.describe 'Webhooks', type: :request do
  describe 'when stripe sends payment_intent.succedeed event' do
    let(:user) { create(:user) }
    let(:order) { create(:order, pay_type: 'Card') }
    let(:event) { StripeMock.mock_webhook_event('payment_intent.succeeded', customer: user.stripe_customer_id, metadata: { payment_for: 'order' } ) }
    let(:header) { StripeWebhookHeader.generate_request_header(event) }

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
end
