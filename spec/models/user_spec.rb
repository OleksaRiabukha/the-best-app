# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("simple")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_customer_id     :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#  index_users_on_stripe_customer_id    (stripe_customer_id)
#
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
