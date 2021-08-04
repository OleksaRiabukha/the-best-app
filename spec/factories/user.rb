FactoryBot.define do
  factory :admin, class: "User" do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { "admin" }

    trait :simple_user do
      role { "simple" }
    end
  end
end
