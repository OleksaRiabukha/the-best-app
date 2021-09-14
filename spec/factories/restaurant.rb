require_relative '../support/upload_image'

FactoryBot.define do
  factory :restaurant do
    association :category
    sequence(:name) { |n| "#{Faker::Restaurant.unique.name}-#{n}" }
    phone_number { Faker::PhoneNumber.phone_number }
    website_url { Faker::Internet.url }
    description { Faker::Restaurant.description }

    before(:create) do |restaurant|
      restaurant.restaurant_image.attach(
        io: File.open(UploadImage.restaurant_image_path),
        filename: UploadImage::RESTAURANT_IMAGE_FILENAME,
        content_type: 'image/jpeg'
      )
    end
  end
end
