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

user.expenses.create(amount: 100.0, date: "2024-02-05", category: "Office Supplies")
user.expenses.create(amount: 200.0, date: "2024-02-03", category: "Utilities")
user.expenses.create(amount: 150.0, date: "2024-02-01", category: "Marketing")
user.expenses.create(amount: 300.0, date: "2024-02-02", category: "Rent")
user.expenses.create(amount: 120.0, date: "2024-02-06", category: "Travel")

user.incomes.create(amount: 5000.0, date: "2023-02-05", source: "Salary")
user.incomes.create(amount: 1500.0, date: "2023-02-06", source: "Freelance Work")
user.incomes.create(amount: 3000.0, date: "2023-02-03", source: "Investments")
user.incomes.create(amount: 2000.0, date: "2023-02-02", source: "Bonus")
user.incomes.create(amount: 1000.0, date: "2023-02-04", source: "Consulting Fee")

user.incomes.create(amount: 5000.0, date: "2024-02-05", source: "Salary")
user.incomes.create(amount: 1500.0, date: "2024-02-06", source: "Freelance Work")
user.incomes.create(amount: 3000.0, date: "2024-02-03", source: "Investments")
user.incomes.create(amount: 2000.0, date: "2024-02-02", source: "Bonus")
user.incomes.create(amount: 1000.0, date: "2024-02-04", source: "Consulting Fee")

user.incomes.create(amount: 5000.0, date: "2024-01-05", source: "Salary")
user.incomes.create(amount: 1500.0, date: "2024-02-06", source: "Freelance Work")
user.incomes.create(amount: 3000.0, date: "2024-03-03", source: "Investments")
user.incomes.create(amount: 2000.0, date: "2024-04-02", source: "Bonus")
user.incomes.create(amount: 1000.0, date: "2024-05-04", source: "Consulting Fee")
