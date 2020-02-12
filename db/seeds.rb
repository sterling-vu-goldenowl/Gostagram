# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def get_an_avatar(name)
  "http://api.adorable.io/avatar/400/#{name}"
end

User.create!(
  username: 'sterling_vu',
  name: 'Sterling Vu',
  email: 'sterling.vu.goldenowl@gmail.com',
  password: 'nhinhi',
  password_confirmation: 'nhinhi'
)

49.times do |n|
  name = Faker::Name.name
  password = 'password'
  user = User.create!(
    username: Faker::Internet.user_name,
    name: name,
    email: "example-avatar-#{n + 1}@gmail.com",
    password: password,
    password_confirmation: password
  )
  user.remote_avatar_url = get_an_avatar(name)
  user.save!
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
