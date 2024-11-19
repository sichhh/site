FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(18..65) }
    email { Faker::Internet.email }
    password { "password" }
  end
end
