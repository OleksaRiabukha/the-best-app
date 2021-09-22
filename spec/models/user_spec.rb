require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'making first user admin' do
    let(:user) { create(:user) }
    let(:simple_user) { create(:user) }

    it 'makes first added user in database an admin' do
      expect(user.role).to eq('admin')
      expect(simple_user.role).to eq('simple')
    end

    it 'creates customer on Stripe service using user email' do
      stripe_customer = Stripe::Customer.retrieve(simple_user.stripe_customer_id)
      expect(simple_user.stripe_customer_id).not_to eq(nil)
      expect(simple_user.stripe_customer_id).to eq(stripe_customer.id)
    end

    describe 'associations' do
      it { is_expected.to have_many(:orders) }
    end
  end
end
