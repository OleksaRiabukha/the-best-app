# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
class Category < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :restaurants

  validates :name, presence: true
  validates :name, uniqueness: true

  has_paper_trail
end
