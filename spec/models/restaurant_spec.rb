# == Schema Information
#
# Table name: restaurants
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE), not null
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
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name)}
  end
end
