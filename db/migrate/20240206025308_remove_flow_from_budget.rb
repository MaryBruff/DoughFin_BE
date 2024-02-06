class RemoveFlowFromBudget < ActiveRecord::Migration[7.1]
  def change
    remove_column :budgets, :flow, :string
  end
end
