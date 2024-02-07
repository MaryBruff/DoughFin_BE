# frozen_string_literal: true

module Types
  class CashFlowType < Types::BaseObject
    field :username, String, null: true
    field :years, [Types::YearType], null: true
  end
end
