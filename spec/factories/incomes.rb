FactoryBot.define do
  factory :income do
    user { nil }
    source { "MyString" }
    amount { 1.5 }
    date { "2024-01-31" }
  end
end
