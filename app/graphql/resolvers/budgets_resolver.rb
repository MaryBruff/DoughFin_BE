module Resolvers
  class BudgetsResolver < Resolvers::BaseResolver
    ## allows for optional additional queries such as month and category
    argument :month, String, required: false
    argument :category, String, required: false

    type [Types::BudgetType], null: false

    def resolve(month: nil, category: nil)
      ## defaults as nil for both argument parameters and determines the proper response
      if month.present? && category.present?
        budgets = object.budgets.where(month: month, category: category)
        expenses = Expense.all.where("to_char(date, 'YYYY-MM') = ? AND category = ?", month, category)
        binding.pry
        budget = calculate_expenses(budgets, expenses)
      else
        object.budgets
      end
    end

    def calculate_expenses(budgets, expenses)
      budgets.map do |budget|
        sum_expenses = expenses.sum(:amount)
        amount_remaining = budget.amount - sum_expenses
        pct_remaining = if budget.amount > 0
                         ((amnt_remaining/budget.amount) * 100).round(1)
                        else
                          0
                        end

        {
          budget: budget,
          binding.pry
          amountRemaining: amount_remaining,
          pctRemaining: pct_remaining
        }
      end
    end
  end
end
