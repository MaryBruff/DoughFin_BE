require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :incomes }
    it { should have_many :expenses }
    it { should have_many :budgets }
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  it "creates a user_spec.rb with all attributes" do
    user = User.create(username: "moneybaggins", email: "moneybaggins@bigbanktakelilbank.doge")
    expect(user).to have_attributes(username: "moneybaggins")
    expect(user).to have_attributes(email: "moneybaggins@bigbanktakelilbank.doge")
  end
end
