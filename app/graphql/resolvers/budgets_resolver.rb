module Resolvers
  class BudgetsResolver < Resolvers::BaseResolver
    argument :month, String, required: false
    argument :category, String, required: false

    type [Types::BudgetType], null: false

    def resolve(month: nil, category: nil)
      if month.present? && category.present?
        object.budgets.where(month: month, category: category)
      else
        object.budgets
      end
    end
  end
end