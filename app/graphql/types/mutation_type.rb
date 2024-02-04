# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :budget, mutation: Mutations::Budget
    # TODO: remove me
    field :delete_expense, mutation: Mutations::DeleteExpense
    field :delete_income, mutation: Mutations::DeleteIncome
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end
  end
end
