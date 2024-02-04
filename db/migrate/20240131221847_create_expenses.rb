class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.string :vendor
      t.float :amount
      t.string :status, default: "projected"
      t.date :date

      t.timestamps
    end
  end
end
