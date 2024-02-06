class Mutations::CreateBudget < Mutations::BaseMutation
  argument :userId, Integer, required: true
  argument :month, String, required: true
  argument :category, String, required: true
  argument :amount, Float, required: true
  argument :flow, String, required: true

  field :user_id, Integer, null: false
  field :month, String, null: true
  field :category, String, null: true
  field :amount, Float, null: true
  field :flow, String, null: true

  def resolve(input)
    user_id = input[:userId]
    month = input[:month]
    category = input[:category]
    amount = input[:amount]
    flow = input[:flow]

    User.find(user_id).budgets.create!(month: month, category: category, amount: amount, flow: flow)
  end
end