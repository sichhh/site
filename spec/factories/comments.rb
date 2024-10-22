FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    article
    status { "public" }
    user 

    # Можно добавить трейт для создания нескольких комментариев к статье
    trait :with_comments do
       after(:create) do |comment|
         create_list(:comment, 3, article: comment.article) 
       end
     end
  end
end 
