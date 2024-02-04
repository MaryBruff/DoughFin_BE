class Mutations::CreateIncome < Mutations::BaseMutation
  argument :input, Types::IncomeInputType, required: true

  field :user, Types::UserType, null: false
  field :source, String, null: false
  field :amount, Float, null: false
  field :date, GraphQL::Types::ISO8601Date, null: false

  def resolve(input)
    new_income = Income.new(
      user_id: input[:user_id],
      source: input[:source],
      amount: input[:amount],
      date: input[:date],
    )

    if new_income.save
      {
        source: source,
        amount: amount,
        date: date,
      }
    else
      {
        income: nil,
        errors: new_income.errors.full_messages,
      }
    end
  end
end