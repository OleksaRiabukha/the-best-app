class GeocodedAddress < ApplicationRecord
  belongs_to :order

  geocoded_by :address
  after_validation :geocode

  def address
    [city, street, building].compact.join(', ')
  end
end
