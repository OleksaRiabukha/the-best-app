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
class Coupon < ApplicationRecord
  belongs_to :user, optional: true

  validates :coupon_number, :initial_amount, presence: true
  validates :coupon_number, uniqueness: true

  def self.save_coupon(coupon_params, user)
    coupon_number, initial_amount, for_present = coupon_params.values_at(:coupon_number, :amount, :for_present)
    coupon = Coupon.new(coupon_number: coupon_number,
                        initial_amount: initial_amount,
                        amount_left: initial_amount,
                        for_present: for_present,
                        user_id: user.id)

    if coupon.valid?
      coupon.save
    else
      logger.error "Encountered errors: #{coupon.errors.full_messages}"
      throw :abort
    end
  end
end
