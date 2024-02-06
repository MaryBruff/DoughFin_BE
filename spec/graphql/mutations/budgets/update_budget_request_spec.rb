require "rails_helper"

RSpec.describe Mutations::UpdateBudget, type: :request do
  describe "resolve" do
    it "successfully updates a budget with all parameters present" do
      user = create(:user)
      user.budgets = [create(:budget)]
      budget = user.budgets.first

      expect(user.budgets.length).to eq(1)
      expect(budget.month).to_not eq("January")
      expect(budget.category).to_not eq("Electronics")
      expect(budget.amount).to_not eq(3500.00)

      mutation = <<~GQL
      mutation {
        updateBudget(input: {
          id: #{budget.id}
          month: "January"
          category: "Electronics"
          amount: 3500.00
        }) {
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
      data = json_response[:data][:updateBudget][:budget]

      expect(data).to have_key(:month)
      expect(data[:month]).to eq("January")
      expect(data).to have_key(:category)
      expect(data[:category]).to eq("Electronics")
      expect(data).to have_key(:amount)
      expect(data[:amount]).to eq(3500.00)
    end

    it "successfully updates a budget with some parameters present" do
      user = create(:user)
      user.budgets = [create(:budget)]
      budget = user.budgets.first

      expect(user.budgets.length).to eq(1)
      expect(budget.month).to_not eq("January")
      expect(budget.category).to_not eq("Electronics")
      expect(budget.amount).to_not eq(3500.00)

      mutation = <<~GQL
      mutation {
        updateBudget(input: {
          id: #{budget.id}
          month: "January"
          category: "Electronics"
        }) {
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
      data = json_response[:data][:updateBudget][:budget]

      expect(data).to have_key(:month)
      expect(data[:month]).to eq("January")
      expect(data).to have_key(:category)
      expect(data[:category]).to eq("Electronics")
      expect(data).to have_key(:amount)
      expect(data[:amount]).to_not eq(3500.00)
      expect(data[:amount]).to eq(budget.amount)
    end
  end
end
