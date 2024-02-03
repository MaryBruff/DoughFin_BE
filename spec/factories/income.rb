require "faker"

FactoryBot.define do
  factory :income do
    association :user

    source { Faker::Commerce.brand }
    amount { Faker::Number.positive(from: 781, to: 9999) }
    date { Date.today }
  end
end
