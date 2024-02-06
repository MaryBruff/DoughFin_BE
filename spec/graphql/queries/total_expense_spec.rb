require "rails_helper"

RSpec.describe Queries::TotalExpenseQuery, type: :request do
  describe "resolve" do
    it "successfully gets the sum of all expense for a user" do
      user = create(:user)
      user.expenses = create_list(:expense, 5)

      expect(user.expenses.length).to eq(5)
      
      query = <<~GQL
        query {
          totalExpense(userId: #{user.id})
        }
      GQL
      
      post "/graphql", params: {query: query}
      json_response = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
      data = json_response[:data]

      expect(data).to have_key(:totalExpense)
      expect(data[:totalExpense]).to eq(user.expenses.sum(&:amount))
    end
  end
end
