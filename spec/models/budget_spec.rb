require "rails_helper"

RSpec.describe Budget, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:month) }

  describe "instance methods" do
    describe "#categroies" do
      it "returns all unique categories" do
        user = create :user
        5.times do
          create :budget, user: user, category: "Food"
        end

        user.budgets.categories

        expect(user.budgets.categories.size).to eq 1
      end
    end
  end
end
