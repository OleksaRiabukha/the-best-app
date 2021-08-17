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

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_paper_trail

  private

  def make_admin!
    self.role = ADMIN unless User.any?
  end
end
