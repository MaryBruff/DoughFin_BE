require "rails_helper"

RSpec.describe "Get Cash Flow", type: :request do
  it "returns month by month cash flow" do
    user = create(:user)
    user.expenses = create_list(:expense, 10)
    user.incomes = create_list(:income, 10)
    query = <<~GQL
      query getCashFlow($email: String!) {
        user(email: $email) {
              id
              cashFlows {
                month
                year
                totalIncome
                totalExpense
              }
        }
      }
    GQL

    post "/graphql", params: {query: query, variables: {email: user.email}}

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    # binding.pry
    expect(data).to have_key(:cashFlow)
    expect(data[:cashFlow]).to be_a Hash

    expect(data[:cashFlow]).to have_key(:username)
    expect(data[:cashFlow][:username]).to be_a String
    
    expect(data[:cashFlow]).to have_key(:years)
    expect(data[:cashFlow][:years]).to be_a Array
    
    data[:cashFlow][:years].each do |year|
      expect(year).to have_key(:year)
      expect(year[:year]).to be_a String

      expect(year).to have_key(:months)
      expect(year[:months]).to be_a Array

      year[:months].each do |month|
        expect(month).to have_key(:month)
        expect(month[:month]).to be_a String

        expect(month).to have_key(:income)
        expect(month[:income]).to be_a Float

        expect(month).to have_key(:expenses)
        expect(month[:expenses]).to be_a Float
      end
    end
  end
end
