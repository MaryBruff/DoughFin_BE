class Mutations::DeleteExpense < Mutations::BaseMutation
  argument :expenseId, Integer, required: true

  field :expense, Types::ExpenseType, null: false
  field :code, Integer, null: false
  field :message, String, null: false
  field :success, Boolean, null: false

  def resolve(expenseId)
    expense = Expense.find_by(id: expenseId.first)
    
    if expense
      expense.destroy!
      {
        code: 204,
        message: "Successfully deleted expense",
        success: true,
      }
    else 
      {
        code: 404,
        message: "No expense found with expenseId #{expenseId.first.last}",
        success: false,
      }
    end
  end
end