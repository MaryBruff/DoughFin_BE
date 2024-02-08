module Types
  class YearType < Types::BaseObject
    field :year, String, null: true
    field :months, [Types::MonthType], null: true
  end
end
