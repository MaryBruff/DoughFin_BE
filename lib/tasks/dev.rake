namespace :dev do
  desc "Fill the database with sample data for development"
  task seed: :environment do
    require "factory_bot_rails"
    Expense.destroy_all
    Budget.destroy_all
    Income.destroy_all
    User.destroy_all
    include FactoryBot::Syntax::Methods

    user = User.create!(username: "johnjakob", email: "email@email.com")
    # Expenses
    26.times { create :expense, user: user, date: "2024-02-" + rand(1..28).to_s }
    26.times { create :expense, user: user, date: "2024-01-" + rand(1..28).to_s }
    # Budgets
    26.times { create :budget, user: user, month: "2024-02", category: user.expenses.pluck(:category).sample }
    # Incomes
    3.times { create :income, user: user, date: "2024-02-" + rand(1..28).to_s }
    3.times { create :income, user: user, date: "2024-01-" + rand(1..28).to_s }
  end
end
