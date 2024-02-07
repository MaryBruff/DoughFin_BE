module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :transactions, [Types::TransactionType], null: true
    field :budgets, resolver: Resolvers::BudgetsResolver
    field :username, String, null: false
    field :email, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
