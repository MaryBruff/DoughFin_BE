# types/month_type.rb
module Types
  class MonthType < Types::BaseObject
    field :month, String, null: true
    field :income, Float, null: true
    field :expenses, Float, null: true
  end
end
