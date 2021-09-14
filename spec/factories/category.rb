FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::Restaurant.type}-#{n}" }
    description { Faker::Restaurant.description }
  end
end
