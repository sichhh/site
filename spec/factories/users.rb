FactoryBot.define do
  factory :user do
    first_name { "name" }
    last_name { "lustname" }
    age { "18" }
    email { "user@example.com" }
    password { "password" }
  end
end
