require "rails_helper"

RSpec.describe Mutations::DeleteExpense, type: :request do
  describe "resolve" do
    it "successfully removes an expense" do
      user = create(:user)
      user.expenses = create_list(:expense, 5)
      expense = Expense.last

      mutation = <<~GQL
        mutation {
          deleteExpense(input: { expenseId: #{expense.id}}) {
              code
              message
              success
              }
            }
      GQL

      expect(user.expenses.length).to eq(5)

      post "/graphql", params: {query: mutation}

      expect(response).to be_successful

      json_response = JSON.parse(response.body)
      data = json_response["data"]["deleteExpense"]

      expect(data["code"]).to eq(204)
      expect(data["message"]).to eq("Successfully deleted expense")
      expect(data["success"]).to be(true)

      expect(Expense.all.length).to eq(4)
    end
  end

  describe "sad paths" do
    it "will gracefully handle no expense found" do
      user = create(:user)
      user.expenses = create_list(:expense, 3)

      mutation = <<~GQL
        mutation {
          deleteExpense(input: { expenseId: 123123123}) {
              code
              message
              success
              }
            }
      GQL

      expect(user.expenses.length).to eq(3)

      post "/graphql", params: {query: mutation}

      json_response = JSON.parse(response.body)
      data = json_response["data"]["deleteExpense"]

      expect(data["code"]).to eq(404)
      expect(data["message"]).to eq("No expense found with expenseId 123123123")
      expect(data["success"]).to be(false)

      expect(Expense.all.length).to eq(3)
    end
  end
end
