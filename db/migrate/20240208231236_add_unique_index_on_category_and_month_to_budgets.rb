class AddUniqueIndexOnCategoryAndMonthToBudgets < ActiveRecord::Migration[7.1]
  def change
    add_index :budgets, [:category, :month], unique: true
  end
end
