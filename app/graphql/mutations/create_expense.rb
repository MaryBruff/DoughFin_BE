class Mutations::CreateExpense < Mutations::BaseMutation
  argument :userId, ID, required: true
  argument :vendor, String, required: true
  argument :category, String, required: true
  argument :amount, Float, required: true
  argument :date, String, required: true

  field :user_id, ID, null: false
  field :expense, Types::ExpenseType, null: false

  def resolve(input)
    user_id = input[:userId]
    vendor = input[:vendor]
    category = input[:category]
    amount = input[:amount]
    date = input[:date]

    expense = User.find(user_id).expenses.create!(vendor: vendor, category: category, amount: amount, date: date)

    raise GraphQL::ExecutionError, expense.errors.full_messages.join(", ") unless expense.persisted?

    {
      user_id: user_id,
      expense: expense
    }
  end
end
