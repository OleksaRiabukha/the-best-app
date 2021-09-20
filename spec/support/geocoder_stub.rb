module GeocoderStub
  def self.stub(city, street, building)
    Geocoder.configure(lookup: :test)
    full_address = [city, street, building].compact.join(', ')

    Geocoder::Lookup::Test.set_default_stub(
      [
        {
          'coordinates' => [Faker::Address.latitude, Faker::Address.longitude],
          'address' => full_address,
          'city' => city,
          'street' => street,
          'building' => building
        }
      ]
    )
  end
end
