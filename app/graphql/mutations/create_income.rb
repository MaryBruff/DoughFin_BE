class Mutations::CreateIncome < Mutations::BaseMutation
  argument :userId, ID, required: true
  argument :source, String, required: true
  argument :amount, Float, required: true
  argument :date, String, required: true

  field :user_id, Integer, null: false
  field :source, String, null: false
  field :amount, Float, null: false
  field :date, String, null: false

  def resolve(input)
    user_id = input[:userId]
    source = input[:source]
    amount = input[:amount]
    date = input[:date]

    User.find(user_id).incomes.create!(source: source, amount: amount, date: date)
  end
end
