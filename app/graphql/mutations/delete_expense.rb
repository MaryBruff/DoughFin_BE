class Mutations::DeleteExpense < Mutations::BaseMutation
  argument :expenseId, Integer, required: true

  field :expense, Types::ExpenseType, null: false
  field :code, Integer, null: false
  field :message, String, null: false
  field :success, Boolean, null: false

  def resolve(expense_id)
    expense = Expense.find_by(id: expense_id.first)

    if expense
      expense.destroy!
      {
        code: 204,
        message: "Successfully deleted expense",
        success: true
      }
    else
      {
        code: 404,
        message: "No expense found with expenseId #{expense_id.first.last}",
        success: false
      }
    end
  end
end
