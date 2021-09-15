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
#
class User < ApplicationRecord
  ADMIN = :admin
  SIMPLE = :simple

  ROLES = [SIMPLE, ADMIN].freeze

  enum role: ROLES

  before_save :make_admin!
  after_create :assign_stripe_id

  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end


  private

  def make_admin!
    self.role = ADMIN unless User.any?
  end

  def assign_stripe_id
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
