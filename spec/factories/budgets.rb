require "faker"

FactoryBot.define do
  factory :budget do
    association :user

    month { "MyString" }
    amount { 1.5 }
    category { "MyString" }
    flow { "MyString" }
  end
end
