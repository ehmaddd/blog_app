FactoryBot.define do
  factory :post do
    title { 'Sample Post Title' }
    text { 'This is the content of the post.' }
    association :author, factory: :user

    trait :with_comments do
      after(:create) do |post|
        create_list(:comment, 2, post: post)
      end
    end

    trait :with_likes do
      after(:create) do |post|
        create_list(:like, 5, post: post)
      end
    end
  end
end
