class Category < ApplicationRecord
  default_scope { order(created_at: :desc) }

  validates :name, presence: true
  validates :name, uniqueness: true
end
