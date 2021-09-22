FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }

    before(:create) do |user|
      stripe_customer = Stripe::Customer.create({ email: user.email })
      user.stripe_customer_id = stripe_customer.id unless user.admin?
    end
  end
end
