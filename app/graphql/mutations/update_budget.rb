class Mutations::UpdateBudget < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :month, String, required: false
  argument :category, String, required: false
  argument :amount, Float, required: false

  field :budget, Types::BudgetType, null: true

  def resolve(id:, **attributes) # finds budget, updates budget, returns budget
    budget = Budget.find(id)

    budget.update(attributes.compact)
    { budget: budget }
  end
end