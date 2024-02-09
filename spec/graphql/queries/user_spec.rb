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

    expect(response).to be_successful
      
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data][:user]

    expect(data[:id]).to eq(user.id.to_s)
    expect(data[:username]).to eq(user.username)
    expect(data[:email]).to eq(user.email)
  end

  describe "sad paths" do
    it "must have a user" do
      post "/graphql", params: {query: query, variables: {email: "not_a_real_email@email.com"}}

      expect(response).to be_successful # graphql responses should always be successful, even when an error occurs
      
      json = JSON.parse(response.body, symbolize_names: true)
      errors = json[:errors]
      
      expect(errors.first).to have_key(:message)
      expect(errors.first[:message]).to eq("User not found.")
    end
  end
end
