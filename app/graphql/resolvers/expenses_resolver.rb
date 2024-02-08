require "date"

module Resolvers
  class ExpensesResolver < Resolvers::BaseResolver
    ## allows for optional additional queries such as month and category
    argument :month, String, required: false ## month = "2024-02"
    argument :category, String, required: false ## category = "Groceries"

    type [Types::ExpenseType], null: false

    def resolve(month: nil, category: nil)
      ## defaults as nil for both argument parameters and determines the proper response
      if month.present? && category.present?
        object.expenses.where("to_char(date, 'YYYY-MM') = ? AND category = ?", month, category)
      else
        object.expenses
      end
    end
  end
end
