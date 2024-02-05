class Mutations::CreateExpense < Mutations::BaseMutation
  argument :userId, Integer, required: true
  argument :vendor, String, required: true
  argument :category, String, required: true
  argument :amount, Float, required: true
  argument :date, String, required: true

  field :user_id, Integer, null: false
  field :vendor, String, null: true
  field :category, String, null: true
  field :amount, Float, null: true
  field :date, String, null: true

  def resolve(input)
    user_id = input[:userId]
    vendor = input[:vendor]
    category = input[:category]
    amount = input[:amount]
    date = input[:date]

    User.find(user_id).expenses.create!(vendor: vendor, category: category, amount: amount, date: date)
  end
end
