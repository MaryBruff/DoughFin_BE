module Queries
  class TotalIncomeQuery < GraphQL::Schema::Resolver
    argument :user_id, ID, required: true

    type Float, null: false

    def resolve(user_id:)
      user = User.find(user_id)
      user.incomes.sum(:amount)
    end
  end
end