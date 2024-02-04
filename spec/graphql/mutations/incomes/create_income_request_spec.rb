require 'rails_helper'

RSpec.describe Mutations::CreateIncome, type: :request do
  describe "resolve" do
    # it "successfully creates an income" do
      let(:user) { create(:user) }

      # mutation = <<~GQL
      #   mutation {
      #     createIncome(input: {
      #       user_id: #{user.id},
      #       source: "#{source}",
      #       amount: #{amount},
      #       date: "#{date}",
      #       }) {
      #         source
      #         amount
      #         date
      #         }
      #       }
      # GQL

      # mutation = <<~GQL
      #   mutation CreateIncome($user_id: Int!, $source: String!, $amount: Float!, $date: ISO8601Date!) {
      #     createIncome(input: {
      #       user_id: #{user.id},
      #       source: "#{source}",
      #       amount: #{amount},
      #       date: "#{date}",
      #       }) {
      #       source
      #       amount
      #       date
      #     }
      #   }
      # GQL

      # input = {
      #     "user_id" => user.id,
      #     "source" => source,
      #     "amount" => amount,
      #     "date" => date,
      # }

      let(:context) { {} }
      let(:variables) do
        {
          "input" => {
            "user_id" => user.id,
            "source" => "Paycheck",
            "amount" => 2345.12,
            "date" => "2023-12-15"
          }
      }
      end

      let(:subject) {
        DoughFinBeSchema.execute(
          query_string,
          context: context,
          variables: variables
        )
      }
      
      # mutation = <<~GQL
      #   mutation CreateIncome($input: IncomeInputType!) {
      #     createIncome(input: $input) {
      #       source
      #       amount
      #       date
      #     }
      #   }
      # GQL

      let(:query_string) do
        'mutation CreateIncome($input: CreateInputType!) {
          createIncome(input: $input) {
            source
            amount
            date
          }
        }'
      end

      it "creates an income" do
        #expect(user.incomes.length).to eq(0)
        expect(Income.all.length).to eq(0)
        DoughFinBeSchema.execute(
        query_string,
        context: context,
        variables: variables
        )
        require 'pry'; binding.pry
        expect(Income.all.length).to eq(1)
        #expect(user.incomes.length).to eq(1)
        #require 'pry'; binding.pry
      end
      # post "/graphql", params: { query: mutation }
      # json_response = JSON.parse(response.body)
    # end
  end
end