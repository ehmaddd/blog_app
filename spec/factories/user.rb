FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { Faker::Name.photo }
  end
end
