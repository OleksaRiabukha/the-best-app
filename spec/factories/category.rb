FactoryBot.define do
  factory :category do
    name { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
  end
end
