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
  has_many :cart_items

  before_destroy :ensure_not_referenced_by_any_cart_item

  validates :name, :description, :ingredients, :price, presence: true

  private

  def ensure_not_referenced_by_any_cart_item
    throw :abort, errors.add(:base, 'Someone has this item in a cart.') unless cart_items.empty?
  end
end
