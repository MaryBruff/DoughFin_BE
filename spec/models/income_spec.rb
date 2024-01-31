require 'rails_helper'

RSpec.describe Income, type: :model do
  describe "relationships" do
    it {should belong_to :user}
  end

  it "creates an income with all attributes" do
    user = User.create(username: "josephlee", email: "josephlee@gmail.com")
    income = Income.create(user_id: user.id, source: "paycheck", amount: 2375.29, date: "2023-01-31")
    
    expect(income).to have_attributes(user_id: user.id)
    expect(income).to have_attributes(source: "paycheck")
    expect(income).to have_attributes(amount: 2375.29)
    expect(income.date.strftime("%Y-%m-%d")).to eq("2023-01-31")
  end
end
