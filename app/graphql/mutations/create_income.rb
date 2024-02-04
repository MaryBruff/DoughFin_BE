class Mutations::CreateIncome < Mutations::BaseMutation
  # argument :input, Types::IncomeInputType, required: true
  argument :userId, Int, required: true
  argument :source, String, required: true
  argument :amount, Float, required: true
  argument :date, String, required: true

  type Types::IncomeType
  # field :user, Types::UserType, null: false
  # field :source, String, null: false
  # field :amount, Float, null: false
  # field :date, GraphQL::Types::ISO8601Date, null: false

  def resolve(userId:, source:, amount:, date:)
     user_id = :userId
    source = :source
    amount = :amount
    date = :date

    User.find(user_id).incomes.create!(source: source, amount: amount, date: date)
    # new_income = Income.new(
    #   # user_id: input[:user_id],
    #   source: source,
    #   amount: amount,
    #   date: date
    # )

    # if new_income.save
    #   {
    #     source: source,
    #     amount: amount,
    #     date: date
    #   }
    # else
    #   {
    #     income: nil,
    #     errors: new_income.errors.full_messages
    #   }
    # end
  end
end