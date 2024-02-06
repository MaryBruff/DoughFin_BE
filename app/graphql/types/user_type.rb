module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :transactions, [Types::TransactionType], null: true
    field :username, String, null: false
    field :email, String, null: false
    field :currentIncome, Types::CurrentIncomeType, null: true do
      description "Returns the current income and percent change"
    end
    field :currentExpense, Types::CurrentExpenseType, null: true do
      description "Returns the current expense and percent change"
    end
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def currentIncome
      current_month_income = object.incomes.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)

      previous_month_income = object.incomes.where("date >= ? AND date <= ?", 1.month.ago.at_beginning_of_month, 1.month.ago.at_end_of_month).sum(:amount)

      pct_change = (previous_month_income.zero? ? 0 : (current_month_income - previous_month_income) / previous_month_income.to_f) * 100

      {
        amount: current_month_income,
        pctChange: pct_change
      }
    end

    def currentExpense
      current_month_expense = object.expenses.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)

      previous_month_expense = object.expenses.where("date >= ? AND date <= ?", 1.month.ago.at_beginning_of_month, 1.month.ago.at_end_of_month).sum(:amount)

      pct_change = (previous_month_expense.zero? ? 0 : (current_month_expense - previous_month_expense) / previous_month_expense.to_f) * 100

      {
        amount: current_month_expense,
        pctChange: pct_change
      }
    end
  end
end
