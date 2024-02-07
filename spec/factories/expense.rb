require "faker"

FactoryBot.define do
  factory :expense do
    association :user

    vendor { Faker::Company.name }
    category { Faker::Company.type }
    amount { Faker::Number.positive(from: 1, to: 1000) }
    date { Date.today }
  end
end
