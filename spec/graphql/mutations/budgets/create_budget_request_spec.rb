require "rails_helper"

RSpec.describe Mutations::CreateBudget, type: :request do
  describe "resolve" do
    it "successfully creates a budget" do
      user = create(:user)

      expect(user.budgets.length).to eq(0)

      mutation = <<~GQL
        mutation {
          createBudget(input: {userId: #{user.id}, month: "January", category: "Electronics", amount: 3500.00}) {
            userId
            budget {
              id
              month
              category
              amount
            }
          }
        }
      GQL

      post "/graphql", params: {query: mutation}
      json_response = JSON.parse(response.body, symbolize_names: true)
      data = json_response[:data][:createBudget]

      refetch_user = User.find(user.id)

      expect(data).to have_key(:userId)
      expect(data[:userId]).to eq(refetch_user.id.to_s)

      data = data[:budget]
      expect(data).to have_key(:month)
      expect(data[:month]).to eq("January")
      expect(data).to have_key(:category)
      expect(data[:category]).to eq("electronics")
      expect(data).to have_key(:amount)
      expect(data[:amount]).to eq(3500.00)
    end
  end
end
