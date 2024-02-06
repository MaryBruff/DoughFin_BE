require "rails_helper"

RSpec.describe Queries::TotalIncomeQuery, type: :request do
  describe "resolve" do
    it "successfully gets the sum of all incomes for a user" do
      user = create(:user)
      user.incomes = create_list(:income, 5)

      expect(user.incomes.length).to eq(5)
      
      query = <<~GQL
        query {
          totalIncome(userId: #{user.id})
        }
      GQL
      
      post "/graphql", params: {query: query}
      json_response = JSON.parse(response.body, symbolize_names: true)
      data = json_response[:data]

      expect(data).to have_key(:totalIncome)
      expect(data[:totalIncome]).to eq(user.incomes.sum(&:amount))
    end
  end
end
