FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.unique.name }
    phone_number { Faker::PhoneNumber.phone_number }
    website_url { Faker::Internet.url }
    description { Faker::Restaurant.description }

    factory :restaurant_with_menu_items do
      transient do
        menu_items_count { 2 }
      end
    end
  end
end
