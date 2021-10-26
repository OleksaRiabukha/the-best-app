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
class Order < ApplicationRecord
  default_scope { order(created_at: :desc) }

  CARD = :Card
  CASH = :Cash
  PENDING_CARD_PAYMENT = :pending_card_payment
  PENDING_CASH_PAYMENT = :pending_cash_payment
  PAID = :paid

  PAYMENT_TYPES = [CARD, CASH].freeze
  PAYMENT_STATUS = [PENDING_CARD_PAYMENT, PENDING_CASH_PAYMENT, PAID].freeze

  enum pay_type: PAYMENT_TYPES
  enum payment_status: PAYMENT_STATUS

  before_create :set_payment_status

  has_many :cart_items, dependent: :destroy
  belongs_to :user
  has_one :geocoded_address, dependent: :destroy

  validates :city, :street, :building, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_cart_items_from_cart(cart)
    cart.cart_items.each do |item|
      item.cart_id = nil
      cart_items << item
    end
    update(total_price: cart.total_cart_price) unless id.nil?
    self.total_price = cart.total_cart_price if id.nil?
  end

  def add_stripe_payment_id(stripe_payment_id)
    update(stripe_payment_id: stripe_payment_id)
  end

  def set_payment_status
    self.payment_status = PENDING_CARD_PAYMENT if pay_type == 'Card'
    self.payment_status = PENDING_CASH_PAYMENT if pay_type == 'Cash'
  end

  def paid
    update(payment_status: PAID)
  end

  def decompose_address(address)
    self.street, self.building, self.city = address.split(', ')
  end
end
