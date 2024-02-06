class Mutations::UpdateBudget < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :month, String, required: false
  argument :category, String, required: false
  argument :amount, Float, required: false

  field :budget, Types::BudgetType, null: true

  def resolve(input)
    budget_id = input[:id]
    month = input[:month]
    category = input[:category]
    amount = input[:amount]

   budget = Budget.find(budget_id)
    budget.update(month: month, category: category, amount: amount)
    { budget: budget }
  end
end