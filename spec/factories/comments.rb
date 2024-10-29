FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    article
    status { "public" }
    user
  end
end
