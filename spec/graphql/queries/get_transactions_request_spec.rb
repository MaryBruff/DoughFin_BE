require "rails_helper"

RSpec.describe "Get Transactions", type: :request do
  let!(:user) { create :user }

  let(:query) do
    <<-GRAPHQL
      query getTransactions($userId: ID!) {
        user(id: $userId) {
          user {
            id
          }
          transactions
        }
      }
    GRAPHQL
  end

  it "returns all of a user's transactions" do
    user = create(:user)
    user.expenses = create_list(:expense, 5)
    user.incomes = create_list(:income, 5)

    post "/graphql", params: {query: query, variables: {userId: user.id}}

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]

    expect(data[:user][:id]).to eq(user.id.to_s)
    data[:expenses].each do |transaction|
      expect(transaction).to have_key(:id)
      expect(transaction[:id]).to be_a Integer
      
      expect(transaction).to have_key(:description)
      expect(transaction[:description]).to be_a Integer

      expect(transaction).to have_key(:amount)
      expect(transaction[:amount]).to be_a Integer

      expect(transaction).to have_key(:date)
      expect(transaction[:date]).to be_a Integer
    end
  end
end