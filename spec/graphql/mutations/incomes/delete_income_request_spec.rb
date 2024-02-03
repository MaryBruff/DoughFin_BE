require 'rails_helper'

RSpec.describe Mutations::DeleteIncome, type: :request do
  describe "resolve" do
    it "successfully removes an income" do
      user = create(:user)
      user.incomes = create_list(:income, 5)
      income = Income.last

      mutation = <<~GQL
        mutation {
          deleteIncome(input: { incomeId: #{income.id}}) {
              code
              message
              success
              }
            }
      GQL

      expect(user.incomes.length).to eq(5)

      post '/graphql', params: { query: mutation }

      json_response = JSON.parse(response.body)
      data = json_response['data']['deleteIncome']
      
      expect(data['code']).to eq(204)
      expect(data['message']).to eq("Successfully deleted income")
      expect(data['success']).to be(true)

      expect(Income.all.length).to eq(4)
    end
  end

  describe "sad paths" do
    it "will gracefully handle no income found" do
      user = create(:user)
      user.incomes = create_list(:income, 3)

      mutation = <<~GQL
        mutation {
          deleteIncome(input: { incomeId: 123123123}) {
              code
              message
              success
              }
            }
      GQL

      expect(user.incomes.length).to eq(3)

      post '/graphql', params: { query: mutation }

      json_response = JSON.parse(response.body)
      data = json_response['data']['deleteIncome']

      expect(data['code']).to eq(404)
      expect(data['message']).to eq("No income found with incomeId 123123123")
      expect(data['success']).to be(false)

      expect(Income.all.length).to eq(3)
    end
  end
end