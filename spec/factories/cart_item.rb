FactoryBot.define do
  factory :cart_item do
    association :cart
    association :menu_item
  end
end
