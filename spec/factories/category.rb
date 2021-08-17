FactoryBot.define do
  factory :category do
    name { Faker::Restaurant.unique.type }
    description { Faker::Restaurant.description }
  end
end
