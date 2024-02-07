module Resolvers
  class BudgetsResolver < Resolvers::BaseResolver
    ## allows for optional additional queries such as month and category
    argument :month, String, required: false
    argument :category, String, required: false

    type [Types::BudgetType], null: false

    def resolve(month: nil, category: nil)
      ## defaults as nil for both argument parameters and determines the proper response
      if month.present? && category.present?
        object.budgets.where(month: month, category: category)
      else
        object.budgets
      end
    end
  end
end
