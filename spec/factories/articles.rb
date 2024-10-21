FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    user
    status { "public" }

    trait :with_comments do
      after(:create) do |article|
        create_list(:comment, 3, article: article)
      end
    end
  end
end
