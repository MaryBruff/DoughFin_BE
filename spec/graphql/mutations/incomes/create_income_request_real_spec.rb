require 'rails_helper'

RSpec.describe Mutations::CreateIncome, type: :request do
  describe "resolve" do
    it "successfully creates an income" do
      user = create(:user)
      source = "Paycheck"
      amount = 2315.12
      date = "2023-12-15"

      expect(user.incomes.length).to eq(0)

      mutation = <<~GQL
      mutation CreateIncome($input: IncomeInput!) {
        createIncome(input: $input) {
          user {
            id
          }
          source
          amount
          date
        }
      }
    GQL

    variables = {
      input: {
        user_id: user.id,
        source: source,
        amount: amount,
        date: date
      }
    }

      post '/graphql', params: { query: mutation, variables: variables }

      json_response = JSON.parse(response.body)
require 'pry'; binding.pry
      expect(Income.all.length).to eq(1)
    end
  end
end