module Resolvers
  class BudgetsResolver < Resolvers::BaseResolver
    argument :month, String, required: false
    argument :category, String, required: false

    type [Types::BudgetType], null: false

    def resolve(month: nil, category: nil)
      if month.present? && category.present?
        budgets = object.budgets.where(month: month, category: category)
        expenses = Expense.where("to_char(date, 'YYYY-MM') = ? AND category = ?", month, category)
        calculate_expenses(budgets, expenses)
        binding.pry
      else
        object.budgets
      end
    end

    private
    def calculate_expenses(budgets, expenses)
      budgets.each do |budget|
        sum_expenses = expenses.where(category: budget.category).sum(:amount)
        amount_remaining = budget.amount - sum_expenses
        pct_remaining = if budget.amount > 0
                          ((amount_remaining / budget.amount) * 100).round(1)
                        else
                          0
                        end

        # Assuming you can directly modify the budget object, or you need to return a structure that matches your GraphQL type.
        # If you cannot modify the budget object directly, consider using a presenter or decorator pattern.
        binding.pry
        budget.attributes.merge({
          'amountRemaining' => amount_remaining,
          'pctRemaining' => pct_remaining,
          'candy' => "OK"
        })
      end
    end
  end
end
