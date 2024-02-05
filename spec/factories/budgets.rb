require "faker"

FactoryBot.define do
  factory :budget do
    association :user

    month { "2024-02" }
    amount { Faker::Number.between(from: 1000, to: 100000) }
    category { "Business Incidentals" }
    flow { "expense" }
  end
end
