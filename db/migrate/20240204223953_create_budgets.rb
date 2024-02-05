class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :month
      t.float :amount
      t.string :category
      t.string :flow

      t.timestamps
    end
  end
end
