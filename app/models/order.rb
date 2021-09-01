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
class Order < ApplicationRecord
  CARD = :Card
  CASH = :Cash

  PAYMENT_TYPES = [CARD, CASH].freeze

  enum pay_type: PAYMENT_TYPES

  has_many :cart_items, dependent: :destroy
  belongs_to :user

  validates :city, :street, :building, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_cart_items_from_cart(cart)
    cart.cart_items.each do |item|
      item.cart_id = nil
      cart_items << item
    end
  end
end
