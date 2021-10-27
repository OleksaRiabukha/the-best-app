FactoryBot.define do
  factory :coupon do
    association :user
    coupon_number { Faker::Alphanumeric.alphanumeric(number: 6) }
    initial_amount { Faker::Number.decimal(l_digits: 2) }
    amount_left { Faker::Number.decimal(l_digits: 2) }
    for_present { Faker::Boolean.boolean }

    trait :coupon_params_for_request do
      amount { Faker::Number.decimal(l_digits: 2) }
    end
  end
end
