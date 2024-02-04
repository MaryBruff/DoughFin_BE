require "rails_helper"

RSpec.describe "Users", type: :request do
  let!(:user) { create :user }

  let(:query) do
    <<-GRAPHQL
      query fetchUser($email: String!) {
        user(email: $email) {
          id
          username
          email
        }
      }
    GRAPHQL
  end

  it "returns a user by email" do
    post "/graphql", params: {query: query, variables: {email: user.email}}

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data][:user]

    expect(data[:id]).to eq(user.id.to_s)
    expect(data[:username]).to eq(user.username)
    expect(data[:email]).to eq(user.email)
  end
end
