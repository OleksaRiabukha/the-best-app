# == Schema Information
#
# Table name: restaurants
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(FALSE), not null
#  description  :text
#  name         :string           default(""), not null
#  phone_number :string
#  website_url  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_restaurants_on_name  (name) UNIQUE
#
class Restaurant < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :menu_items, dependent: :destroy

  scope :active, -> { where(active: true) }
  scope :hidden, -> { where(active: false) }

  validates :name, presence: true
  validates :name, uniqueness: true
end
