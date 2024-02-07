require "rails_helper"

RSpec.describe Expense, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should validate_presence_of :category }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :date }
  end

  it "creates an expense with all attributes" do
    user = User.create(username: "moneybaggins", email: "moneybaggins@bigbanktakelilbank.doge")
    expense = Expense.create(user_id: user.id, category: "food", amount: 23.75, date: "2023-05-13")

    expect(expense).to have_attributes(user_id: user.id)
    expect(expense).to have_attributes(category: "food")
    expect(expense).to have_attributes(amount: 23.75)
    expect(expense.date.strftime("%Y-%m-%d")).to eq("2023-05-13")
  end
end
