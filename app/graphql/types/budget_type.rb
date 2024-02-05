# frozen_string_literal: true

module Types
  class BudgetType < Types::BaseObject
    field :month, String, null: false
    field :amount, Float, null: false
    field :category, String, null: false
    field :flow, String, null: false
  end
end
