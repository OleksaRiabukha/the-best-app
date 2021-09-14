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
require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:ingredients) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:restaurant) }
    it { is_expected.to have_one_attached(:menu_item_image) }
  end
end
