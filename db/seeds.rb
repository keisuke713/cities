# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: :Alice,
  email: "test@test.com",
  password: :Baseball713,
  intro: :Hi,
  admin: true
)

100.times do |n|
  User.create!(
    name: :Bob,
    email: "test#{n}@test.com",
    password: :Baseball713,
    intro: :Hi
  )
end
