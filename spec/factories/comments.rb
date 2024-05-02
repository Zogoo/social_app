FactoryBot.define do
  factory :comment do
    author { association :user } 
    post
    context { Faker::Lorem.sentence }
  end
end
