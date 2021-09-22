# == Schema Information
#
# Table name: geocoded_addresses
#
#  id         :bigint           not null, primary key
#  building   :string
#  city       :string
#  latitude   :float
#  longitude  :float
#  street     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_geocoded_addresses_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe GeocodedAddress, type: :model do
  let(:geocoded_address) { create(:geocoded_address) }

  describe 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'creation of a full address' do
    it 'creates a full address with orders city, street and building details' do
      expect(geocoded_address.address).to eq("#{geocoded_address.city}, #{geocoded_address.street}, #{geocoded_address.building}")
    end
  end
end
