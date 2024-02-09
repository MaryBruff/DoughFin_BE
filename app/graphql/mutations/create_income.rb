class Mutations::CreateIncome < Mutations::BaseMutation
  argument :userId, ID, required: true
  argument :source, String, required: true
  argument :amount, Float, required: true
  argument :date, String, required: true

  field :user_id, ID, null: false
  field :income, Types::IncomeType, null: false

  def resolve(input)
    user_id = input[:userId]
    source = input[:source]
    amount = input[:amount]
    date = input[:date]

    income = User.find(user_id).incomes.create!(source: source, amount: amount, date: date)

    raise GraphQL::ExecutionError, income.errors.full_messages.join(", ") unless income.persisted?

    {
      user_id: user_id,
      income: income
    }
  end
end
