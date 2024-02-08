class Mutations::DeleteIncome < Mutations::BaseMutation
  argument :incomeId, ID, required: true

  field :income, Types::IncomeType, null: false
  field :code, Integer, null: false
  field :message, String, null: false
  field :success, Boolean, null: false

  def resolve(incomeId)
    income = Income.find_by(id: incomeId.first)
    if income
      income.destroy!
      {
        code: 204,
        message: "Successfully deleted income",
        success: true
      }
    else
      {
        code: 404,
        message: "No income found with income_id #{incomeId.first.last}",
        success: false
      }
    end
  end
end
