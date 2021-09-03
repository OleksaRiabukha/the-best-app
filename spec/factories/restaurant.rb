FactoryBot.define do
  factory :restaurant do
    association :category
    name { Faker::Restaurant.unique.name }
    phone_number { Faker::PhoneNumber.phone_number }
    website_url { Faker::Internet.url }
    description { Faker::Restaurant.description }

    before(:create) do |restaurant|
      restaurant.restaurant_image.attach(
        io: File.open(UploadImage.image_path),
        filename: 'res3.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
