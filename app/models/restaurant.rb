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
#  category_id  :bigint           not null
#
# Indexes
#
#  index_restaurants_on_category_id  (category_id)
#  index_restaurants_on_name         (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Restaurant < ApplicationRecord
  default_scope { order(created_at: :desc) }

  scope :active, -> { where(active: true) }
  scope :hidden, -> { where(active: false) }

  belongs_to :category
  has_many :menu_items, dependent: :destroy
  has_one_attached :restaurant_image

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :restaurant_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  has_paper_trail
end
