class CreateIncomes < ActiveRecord::Migration[7.1]
  def change
    create_table :incomes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
