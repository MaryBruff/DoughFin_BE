module Queries
  class TotalExpenseQuery < GraphQL::Schema::Resolver
    argument :user_id, ID, required: true

    type Float, null: false

    def resolve(user_id:)
      user = User.find(user_id)
      user.expenses.sum(:amount)
    end
  end
end