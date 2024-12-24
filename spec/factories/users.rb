FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(18..65) }
    email { Faker::Internet.email }
    password { "password" }

    after(:build) do |user|
      user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'default_avatar.png')),
        filename: 'default_avatar.png',
        content_type: 'image/png'
      )
    end
  end
end
