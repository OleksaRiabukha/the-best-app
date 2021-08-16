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
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'associations', type: :model do
    it { should belong_to(:category).class_name('Category') }
  end

  describe 'validations' do
    subject { create(:restaurant) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
