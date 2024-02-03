require 'rails_helper'

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

      post '/graphql', params: { query: mutation }

      json_response = JSON.parse(response.body)
      data = json_response['data']['deleteExpense']
      
      expect(data['code']).to eq(204)
      expect(data['message']).to eq("Successfully deleted expense")
      expect(data['success']).to be(true)

      expect(Expense.all.length).to eq(4)
    end
  end
end