module StaticGoogleMaps
  def self.map(order)
    "https://maps.googleapis.com/maps/api/staticmap?zoom=17&size=800x300&markers=size:large%7Ccolor:red%7C#{order.geocoded_address.latitude}, #{order.geocoded_address.longitude}&key=#{Rails.application.credentials.dig(:google, :api_key)}"
  end
end
