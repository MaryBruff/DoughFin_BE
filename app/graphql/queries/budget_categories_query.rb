module Queries
  class BudgetCategoriesQuery < GraphQL::Schema::Resolver
    type [String], null: false

    def resolve
      object.budgets.pluck(:category).uniq
    end
  end
end
