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
    require 'pry'; binding.pry
  end
end
