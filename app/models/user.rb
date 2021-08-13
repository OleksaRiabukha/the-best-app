# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone_number           :text
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("simple")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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

  after_save :make_admin

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def make_admin
    update_column(:role, ADMIN) if User.any? && self == User.first
  end
end
