module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :transactions, [Types::TransactionType], null: true
    field :username, String, null: false
    field :email, String, null: false
    field :incomes, [Types::IncomeType], null: true
    field :total_income, Float, null: true
    field :expenses, [Types::ExpenseType], null: true
    field :total_expense, Float, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def total_income
      object.incomes.sum(:amount)
    end

    def total_expense
      object.expenses.sum(:amount)
    end
  end
end
