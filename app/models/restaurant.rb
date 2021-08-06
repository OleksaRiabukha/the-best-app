# == Schema Information
#
# Table name: restaurants
#
#  id           :bigint           not null, primary key
#  description  :text
#  hidden       :boolean          default(TRUE), not null
#  name         :string           default(""), not null
#  phone_number :text
#  website_url  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_restaurants_on_name  (name) UNIQUE
#
class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
end
