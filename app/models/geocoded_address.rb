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
class GeocodedAddress < ApplicationRecord
  belongs_to :order

  geocoded_by :address
  after_validation :geocode

  def address
    [city, street, building].compact.join(', ')
  end
end
