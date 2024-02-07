# frozen_string_literal: true

module Types
  class CashFlowType < Types::BaseObject
    # field :username, String, null: true
    # field :years, [Types::YearType], null: true
    field :year, String, null: true
    field :month, String, null: true
    field :total_income, Float, null: true
    field :total_expense, Float, null: true
  end
end
