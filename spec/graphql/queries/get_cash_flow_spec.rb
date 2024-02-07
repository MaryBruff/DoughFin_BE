require "rails_helper"

RSpec.describe "Get Cash Flow", type: :request do
  it "returns month by month cash flow" do
    user = create(:user)
    user.expenses = create_list(:expense, 5)
    user.incomes = create_list(:income, 5)

    query = <<~GQL
      query {
        user(email: "#{user.email}") {
          cashFlow {
            username
            years {
              year
              months {
                month
                income
                expenses
              }
            }
          }
        }
      }
    GQL

    post "/graphql", params: {query: query, variables: {email: user.email}}

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    
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
