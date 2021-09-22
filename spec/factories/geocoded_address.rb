FactoryBot.define do
  factory :geocoded_address do
    association :order
    latitude { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    longitude { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    building { Faker::Address.building_number }
  end
end
