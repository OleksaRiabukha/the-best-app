# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
# Restaurant.destroy_all

5.times do
  Category.create!(name: Faker::Restaurant.type,
                   description: Faker::Restaurant.description)
end

User.create!([
  {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  },
  {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  }
  ])

5.times do
  Restaurant.create!(name: Faker::Restaurant.name,
                     phone_number: Faker::PhoneNumber.phone_number,
                     website_url: Faker::Internet.url,
                     description: Faker::Restaurant.description,
                     category_id: rand(1..5))
end

5.times do
  Restaurant.create!(name: Faker::Restaurant.name,
                     phone_number: Faker::PhoneNumber.phone_number,
                     website_url: Faker::Internet.url,
                     description: Faker::Restaurant.description,
                     active: false,
                     category_id: rand(1..5))
end
