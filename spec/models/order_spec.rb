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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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
end
