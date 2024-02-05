require "faker"

FactoryBot.define do
  factory :expense do
    association :user

    vendor { Faker::Company.name }
    category { Faker::Company.type }
    amount { Faker::Commerce.price(range: 0..999) }
    status { %w[projected paid].sample }
    date { Date.today }
  end
end
