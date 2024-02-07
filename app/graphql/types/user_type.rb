module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :transactions, [Types::TransactionType], null: true
    field :username, String, null: false
    field :email, String, null: false
    field :current_incomes, Types::CurrentIncomesType, null: true do
      description "Returns the current income and percent change"
    end
    field :current_expenses, Types::CurrentExpensesType, null: true do
      description "Returns the current expense and percent change"
    end
    field :cashFlows, [Types::CashFlowType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def current_incomes
      current_month_income = object.incomes.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)

      previous_month_income = object.incomes.where("date >= ? AND date <= ?", 1.month.ago.at_beginning_of_month, 1.month.ago.at_end_of_month).sum(:amount)

      pct_change = (previous_month_income.zero? ? 0 : (current_month_income - previous_month_income) / previous_month_income.to_f) * 100

      {
        amount: current_month_income,
        pctChange: pct_change
      }
    end

    def current_expenses
      current_month_expense = object.expenses.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)

      previous_month_expense = object.expenses.where("date >= ? AND date <= ?", 1.month.ago.at_beginning_of_month, 1.month.ago.at_end_of_month).sum(:amount)

      pct_change = (previous_month_expense.zero? ? 0 : (current_month_expense - previous_month_expense) / previous_month_expense.to_f) * 100

      {
        amount: current_month_expense,
        pctChange: pct_change
      }
    end

    # def cashFlow
    #   {
    #     username: object.username,
    #     years: object.transaction_amounts_by_month_and_year
    #     # years: calculate_cash_flow(object.incomes, object.expenses)
    #   }
    # end

    # def calculate_cash_flow(incomes, expenses)
    #   # we have user's incomes and expenses as 2 arrays
    #   # we want the user incomes sorted by year, then by month
      
      
    #   [
    #     {
    #       year: "2023",
    #       months: [
    #         {
    #           month: "December",
    #           income: incomes.where("date >= ? AND date <= ?", "2023-12-01", "2023-12-31").sum(:amount),
    #           expenses: expenses.where("date >= ? AND date <= ?", "2023-12-01", "2023-12-31").sum(:amount)
    #         }
    #       ]
    #     },
    #     {
    #       year: "2024",
    #       months: [
    #         {
    #           month: "January",
    #           income: incomes.where("date >= ? AND date <= ?", "2024-01-01", "2024-01-31").sum(:amount),
    #           expenses: expenses.where("date >= ? AND date <= ?", "2024-01-01", "2024-01-31").sum(:amount)
    #         }
    #       ]
    #     }
    #   ]
    # end
  end
end
