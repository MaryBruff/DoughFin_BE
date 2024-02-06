# frozen_string_literal: true

module Types
  class BudgetType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :user, Types::UserType, null: false
    field :month, String, null: false
    field :amount, Float, null: false
    field :category, String, null: false
  end
end
