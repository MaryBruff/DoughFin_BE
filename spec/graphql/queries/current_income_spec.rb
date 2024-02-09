require "rails_helper"

RSpec.describe Queries::TotalIncomeQuery, type: :request do
  describe "resolve" do
    it "successfully gets the sum of all incomes for a user" do
      user = create(:user)
      user.incomes.create(source: "Current Month 1", amount: 100.0, date: "2024-02-06")
      user.incomes.create(source: "Current Month 2", amount: 100.0, date: "2024-02-06")
      user.incomes.create(source: "Current Month 3", amount: 100.0, date: "2024-02-06")
      user.incomes.create(source: "Current Month 4", amount: 100.0, date: "2024-02-06")
      user.incomes.create(source: "Current Month 5", amount: 100.0, date: "2024-02-06")
      user.incomes.create(source: "Previous Source", amount: 100.0, date: "2024-01-15")

      expect(user.incomes.length).to eq(6)

      query = <<~GQL
        query { 
          user(id: "#{user.id}") {
            currentIncomes {
              amount
              pctChange
            }
          }
        }
      GQL

      post "/graphql", params: {query: query}
      json_response = JSON.parse(response.body, symbolize_names: true)
      data = json_response[:data]

      expect(data).to have_key(:user)
      expect(data[:user]).to have_key(:currentIncomes)
      expect(data[:user][:currentIncomes]).to have_key(:amount)
      expect(data[:user][:currentIncomes][:amount]).to eq(500.0)
      expect(data[:user][:currentIncomes]).to have_key(:pctChange)
      expect(data[:user][:currentIncomes][:pctChange]).to eq(400.0)
    end
  end
end
