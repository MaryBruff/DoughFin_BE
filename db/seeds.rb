# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(username: "john_smith", email: "email@email.com")

user.expenses.create!(amount: 100.0, date: "2024-02-05", category: "Office Supplies", vendor: "Staples")
user.expenses.create!(amount: 200.0, date: "2024-02-03", category: "Utilities", vendor: "ConEd")
user.expenses.create!(amount: 150.0, date: "2024-02-01", category: "Marketing", vendor: "Google")
user.expenses.create!(amount: 300.0, date: "2024-02-02", category: "Rent", vendor: "Landlord")
user.expenses.create!(amount: 120.0, date: "2024-02-06", category: "Travel", vendor: "Uber")

user.incomes.create!(amount: 5000.0, date: "2024-02-05", source: "Monthly Salary")
user.incomes.create!(amount: 1500.0, date: "2024-02-06", source: "Freelance Design Work")
user.incomes.create!(amount: 3000.0, date: "2024-02-03", source: "Stock Market Investments")
user.incomes.create!(amount: 2000.0, date: "2024-02-02", source: "Annual Bonus")
user.incomes.create!(amount: 1000.0, date: "2024-02-04", source: "Consulting for Startup")

user.incomes.create!(amount: 5000.0, date: "2024-01-05", source: "First Month Salary")
user.incomes.create!(amount: 1500.0, date: "2024-02-06", source: "Graphic Design Freelance")
user.incomes.create!(amount: 3000.0, date: "2024-03-03", source: "Real Estate Investments")
user.incomes.create!(amount: 2000.0, date: "2024-04-02", source: "Quarterly Bonus")
user.incomes.create!(amount: 1000.0, date: "2024-05-04", source: "Tech Consultancy Fee")

# user.incomes.create!(amount: 5000.0, date: "2023-02-05", source: "Salary Payment")
# user.incomes.create!(amount: 1500.0, date: "2023-02-06", source: "Freelance Coding Projects")
# user.incomes.create!(amount: 3000.0, date: "2023-02-03", source: "Investment Dividends")
# user.incomes.create!(amount: 2000.0, date: "2023-02-02", source: "Performance Bonus")
# user.incomes.create!(amount: 1000.0, date: "2023-02-04", source: "Consulting Services")
