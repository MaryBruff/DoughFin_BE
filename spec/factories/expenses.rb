FactoryBot.define do
  factory :expense do
    user { nil }
    category { "MyString" }
    amount { 1.5 }
    type { "" }
    date { "2024-01-31" }
  end
end
