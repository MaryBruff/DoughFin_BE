require 'rails_helper'

RSpec.describe Mutations::CreateIncome, type: :request do
  describe "resolve" do
    it "successfully creates an income" do
      user = create(:user)

    #   post '/graphql', params: { query: query(user_id: user.id) }
    #   json = JSON.parse(response.body)

    #   expect(User.incomes.count).to eq(1)
    # end

  #   it 'returns an income' do
  #     user = create(:user)

  #     post '/graphql', params: { query: query(user_id: user.id) }
  #     json = JSON.parse(response.body)
  #     data = json['data']['createIncome']

  #     expect(data).to include(
  #       'id' => user.id,
  #       'source' => "Paycheck",
  #       'amount' => 2314.12,
  #       'date' => "2023-12-15"
  #     )
  #   end
  # end

  # def query(user_id:)
  #   <<~GQL
  #     mutation {
  #       createIncome(
  #         userId: #{user_id}
  #         source: "Paycheck"
  #         amount: 2314.12
  #         date: "2023-12-15"
  #       ) {
  #         id
  #         source
  #         amount
  #         date
  #         user {
  #           id
  #         }
  #       }
  #     }
  #   GQL
  # end

      # source = "Paycheck"
      # amount = 2315.12
      # date = "2023-12-15"

      expect(user.incomes.length).to eq(0)

      variables = {
        user_id: user.id,
        source: "Paycheck",
        amount: 2312.13,
        date: "2023-12-15"
    }

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
    
      post '/graphql', params: { query: mutation, variables: variables }
      json_response = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
      expect(Income.all.length).to eq(1)
    end
  end
end