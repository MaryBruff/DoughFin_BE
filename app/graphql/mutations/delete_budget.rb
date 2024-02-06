class Mutations::DeleteBudget < Mutations::BaseMutation
  argument :budgetId, Integer, required: true

  field :budget, Types::BudgetType, null: false
  field :code, Integer, null: false
  field :message, String, null: false
  field :success, Boolean, null: false

  def resolve(budget_id)
    budget = Budget.find_by(id: budget_id.first)

    if budget
      budget.destroy!
      {
        code: 204,
        message: "Successfully deleted budget",
        success: true
      }
    else
      {
        code: 404,
        message: "No budget found with budgetId #{budget_id.first.last}",
        success: false
      }
    end
  end
end
