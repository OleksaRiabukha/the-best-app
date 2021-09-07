# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Restaurant.destroy_all

FactoryBot.create_list(:user, 2)
FactoryBot.create_list(:restaurant, 2, active: false)

FactoryBot.create_list(:restaurant, 6, active: true).each do |restaurant|
  FactoryBot.create_list(:menu_item, 6, available: true, restaurant: restaurant)
  FactoryBot.create_list(:menu_item, 2, available: false, restaurant: restaurant)
end
