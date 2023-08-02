FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { Faker::Avatar.image }
    bio { Faker::Lorem.paragraph }
    posts_counter { Faker::Number.between(from: 0, to: 100) }
  end
end
