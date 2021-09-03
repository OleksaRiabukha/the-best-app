FactoryBot.define do
  factory :order do
    association :user
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    building { Faker::Address.building_number }
    appartment_number { Faker::Number.number(digits: 2) }
    pay_type { 'Card' }
  end
end
