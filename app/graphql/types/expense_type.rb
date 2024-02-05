# frozen_string_literal: true

module Types
  class ExpenseType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :user, Types::UserType, null: false
    field :vendor, String, null: true
    field :category, String, null: true
    field :amount, Float, null: true
    field :status, String, null: true
    field :date, GraphQL::Types::ISO8601Date
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
