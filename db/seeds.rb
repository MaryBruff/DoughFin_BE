# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

u1 = User.create!(username: "moneybaggins", email: "moneybaggins@bigbanktakelilbank.doge")
Income.create!(source: "Laundering", amount: 80085.00, user_id: u1.id)
Expense.create!(
  vendor: "ShhShh Hitman, LLC",
  category: "Business Incidentals",
  amount: 8000.00,
  user_id: u1.id,
  date: Date.today
)
Budget.create!(
  month: "2024-02",
  category: "Business Incidentals",
  amount: 10000.00,
  user_id: u1.id,
  flow: "expense"
)

User.create!(username: "john_smith", email: "email@email.com")
# 5.times do
#   user.expenses.create!()
# end
