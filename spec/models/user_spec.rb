require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :incomes }
    it { should have_many :expenses }
  end

  it "creates a user with all attributes" do
    user = User.create(username: "josephlee", email: "josephlee@gmail.com")
    expect(user).to have_attributes(username: "josephlee")
    expect(user).to have_attributes(email: "josephlee@gmail.com")
  end
end
