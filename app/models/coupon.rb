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
  default_scope { order(created_at: :desc) }

  scope :available, -> { where('amount_left > 0') }
  scope :used, -> { where('amount_left = 0.0') }

  belongs_to :user, optional: true

  validates :coupon_number, :initial_amount, presence: true
  validates :coupon_number, uniqueness: true

  def self.save_coupon(coupon_params, user)
    coupon_number, initial_amount, for_present = coupon_params.values_at(:coupon_number, :amount, :for_present)
    coupon = Coupon.new(
      coupon_number: coupon_number,
      initial_amount: initial_amount,
      amount_left: initial_amount,
      for_present: for_present,
      user_id: user.id
    )

    if !coupon.valid?
      logger.error "Encountered errors: #{coupon.errors.full_messages}"
      throw :abort
    end

    coupon.save
  end

  def self.retreive_coupons(user_id, active)
    current_user = User.find(user_id)
    coupons = current_user.coupons
    active = ActiveModel::Type::Boolean.new.cast(active)

    return coupons.available if active

    coupons.used
  end
end
