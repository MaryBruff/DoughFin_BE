# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :budget, mutation: Mutations::Budget
    field :create_budget, mutation: Mutations::CreateBudget
    field :update_budget, mutation: Mutations::UpdateBudget
    field :delete_budget, mutation: Mutations::DeleteBudget
    field :delete_expense, mutation: Mutations::DeleteExpense
    field :delete_income, mutation: Mutations::DeleteIncome
    field :create_income, mutation: Mutations::CreateIncome
    field :create_expense, mutation: Mutations::CreateExpense
  end
end
