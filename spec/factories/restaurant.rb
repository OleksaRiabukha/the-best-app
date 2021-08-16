FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.unique.name }
    phone_number { Faker::PhoneNumber.phone_number }
    website_url { Faker::Internet.url }
    description { Faker::Restaurant.description }
    association :category
  end
end
