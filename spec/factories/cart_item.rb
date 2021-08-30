FactoryBot.define do
  factory :cart_item do
    quantity { Faker::Number.number(digits: 1) }
    price { Faker::Number.decimal }
    association :cart
    association :menu_item
  end
end
