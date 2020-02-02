FactoryBot.define do
  factory :user do
    username { 'Username' }
    email { 'email@example.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
