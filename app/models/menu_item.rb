# == Schema Information
#
# Table name: menu_items
#
#  id            :bigint           not null, primary key
#  available     :boolean          default(FALSE)
#  description   :text             not null
#  discount      :decimal(8, 2)
#  ingredients   :text             not null
#  name          :string           not null
#  price         :decimal(8, 2)    not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#
# Indexes
#
#  index_menu_items_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class MenuItem < ApplicationRecord
  default_scope { order(created_at: :desc) }

  scope :available, -> { where(available: true) }

  belongs_to :restaurant

  validates :name, :description, :ingredients, :price, presence: true
end
