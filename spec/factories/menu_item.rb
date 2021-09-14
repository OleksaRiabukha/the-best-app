FactoryBot.define do
  factory :menu_item do
    association :restaurant
    sequence(:name) { |n| "#{Faker::Food.dish} #{n}" }
    description { Faker::Food.description }
    ingredients { Faker::Food.ingredients }
    price { Faker::Number.decimal(l_digits: 2) }
    discount { Faker::Number.decimal(l_digits: 2) }

    before(:create) do |menu_item|
      menu_item.menu_item_image.attach(
        io: File.open(UploadImage.menu_item_image_path),
        filename: UploadImage::MENU_ITEM_IMAGE_FILENAME,
        content_type: 'image/png'
      )
    end
  end
end
