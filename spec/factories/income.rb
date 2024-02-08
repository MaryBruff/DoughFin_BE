require "faker"

FactoryBot.define do
  factory :income do
    association :user

    source { Faker::Commerce.brand }
    amount { Faker::Number.positive(from: 781, to: 9999) }
    date { Faker::Date.between(from: 100.days.ago, to: Date.today) }
  end
end
