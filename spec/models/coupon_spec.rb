# == Schema Information
#
# Table name: coupons
#
#  id             :bigint           not null, primary key
#  amount_left    :decimal(8, 2)
#  coupon_number  :string           not null
#  for_present    :boolean
#  initial_amount :decimal(8, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_coupons_on_coupon_number  (coupon_number) UNIQUE
#  index_coupons_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'validations' do
    subject { create(:coupon) }
    it { is_expected.to validate_presence_of(:coupon_number) }
    it { is_expected.to validate_presence_of(:initial_amount) }
    it { is_expected.to validate_uniqueness_of(:coupon_number) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
  end
end
