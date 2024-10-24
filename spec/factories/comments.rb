FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    article
    status { "public" }
    user

    trait :with_comments do
      after(:create) do |comment|
        create_list(:comment, 3, article: comment.article)
      end
    end
  end
end
