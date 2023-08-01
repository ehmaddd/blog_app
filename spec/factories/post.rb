FactoryBot.define do
  factory :post do
    title { 'Sample Post Title' }
    text { 'This is the content of the post.' }
    association :author, factory: :user
  end
end
