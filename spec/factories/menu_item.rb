FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    ingredients { Faker::Food.ingredients }
    price { Faker::Number.decimal(l_digits: 2) }
    discount { Faker::Number.decimal(l_digits: 2) }
    association :restaurant
  end
end
