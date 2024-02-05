# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :delete_expense, mutation: Mutations::DeleteExpense
    field :delete_income, mutation: Mutations::DeleteIncome
    field :create_income, mutation: Mutations::CreateIncome
    field :create_expense, mutation: Mutations::CreateExpense
  end
end
