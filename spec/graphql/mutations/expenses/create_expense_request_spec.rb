require "rails_helper"

RSpec.describe Mutations::CreateExpense, type: :request do
  describe "resolve" do
    it "successfully creates an expense" do
      user = create(:user)

      expect(user.expenses.length).to eq(0)

      mutation = <<~GQL
        mutation {
          createExpense(input: {userId: #{user.id}, vendor: "Apple", category: "Electronics", amount: 3500.00, date: "2024-02-02"}) {
            userId
            expense {
              id
              vendor
              category
              amount
              date
            }
          }
        }
      GQL

      post "/graphql", params: {query: mutation}
      json_response = JSON.parse(response.body, symbolize_names: true)
      data = json_response[:data][:createExpense]

      refetch_user = User.find(user.id)

      expect(data).to have_key(:userId)
      expect(data[:userId]).to eq(refetch_user.id.to_s)
      expense = data[:expense]
      expect(expense).to have_key(:vendor)
      expect(expense[:vendor]).to eq("Apple")
      expect(expense).to have_key(:category)
      expect(expense[:category]).to eq("Electronics")
      expect(expense).to have_key(:amount)
      expect(expense[:amount]).to eq(3500.00)
      expect(expense).to have_key(:date)
      expect(expense[:date]).to eq("2024-02-02")
    end
  end
end
