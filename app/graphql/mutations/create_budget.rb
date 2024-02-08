class Mutations::CreateBudget < Mutations::BaseMutation
  argument :userId, ID, required: true
  argument :month, String, required: true
  argument :category, String, required: true
  argument :amount, Float, required: true

  field :user_id, Integer, null: false
  field :month, String, null: true
  field :category, String, null: true
  field :amount, Float, null: true

  def resolve(input) # finds user, creates budget for user with input parameters
    user_id = input[:userId]
    month = input[:month]
    category = input[:category]
    amount = input[:amount]

    User.find(user_id).budgets.create!(month: month, category: category, amount: amount)
  end
end
