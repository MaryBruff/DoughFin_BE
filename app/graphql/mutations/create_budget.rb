class Mutations::CreateBudget < Mutations::BaseMutation
  argument :userId, ID, required: true
  argument :month, String, required: true
  argument :category, String, required: true
  argument :amount, Float, required: true

  field :user_id, ID, null: false
  field :budget, Types::BudgetType, null: false

  def resolve(input) # finds user, creates budget for user with input parameters
    user_id = input[:userId]
    month = input[:month]
    category = input[:category]
    amount = input[:amount]

    budget = User.find(user_id).budgets.create!(month: month, category: category, amount: amount)

    raise GraphQL::ExecutionError, budget.errors.full_messages.join(", ") unless budget.persisted?

    {
      user_id: user_id,
      budget: budget
    }
  end
end
