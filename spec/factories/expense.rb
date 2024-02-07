require "faker"

FactoryBot.define do
  factory :expense do
    association :user

    vendor { Faker::Company.name }
    category { Faker::Company.type }
    amount { Faker::Commerce.price(range: 0..999) }
    date { Faker::Date.between(from: 100.days.ago, to: Date.today) }
  end
end
