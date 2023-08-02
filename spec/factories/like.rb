FactoryBot.define do
  factory :like do
    association :author, factory: :user # Assuming you have a valid association with the User model
    association :post # Assuming you have a valid association with the Post model
  end
end
