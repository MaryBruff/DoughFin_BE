require "rails_helper"

RSpec.describe "Get Budgets by Search Parameters", type: :request do
  it "returns the user's budgets within the specified month and category" do
    user = create(:user)
    user.budgets = create_list(:budget, 1, category: "Groceries", amount: 350.00, month: "2024-02")
    user.expenses = create_list(:expense, 5)
    5.times do
      user.expenses << FactoryBot.create(:expense, user: user, category: "Groceries", amount: 25.00, date: "2024-02-" + format('%02d', rand(1..28)))
    end

    query = <<~GQL
        query GetBudgetsByParams($month: String!, $category: String!, $email: String!) {
          user(email: $email) {
              id
              budgets(month: $month, category: $category) {
                  id
                  month
                  category
                  amount
                  pctRemaining
                  amountRemaining
              }
              expenses(category: $category, month: $month) {
                  id
                  amount
                  date
                  category
              }
          }
      }
    GQL

    post "/graphql", params: {query: query, variables: {
      email: user.email,
      category: "Groceries",
      month: "2024-02"
    }}

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
binding.pry
    expect(data[:user][:id]).to eq(user.id.to_s)

    data[:user][:budgets].each do |budget|
      expect(budget).to have_key(:id)
      expect(budget[:id].to_i).to be_a Integer

      expect(budget).to have_key(:month)
      expect(budget[:month]).to be_a String

      expect(budget).to have_key(:category)
      expect(budget[:category]).to be_a String

      expect(budget).to have_key(:amount)
      expect(budget[:amount]).to be_a Float
    end
  end
end
