FactoryBot.define do
  factory :post do
    user
    context { Faker::Lorem.sentence }
  end
end
