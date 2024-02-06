class User < ApplicationRecord
  has_many :expenses
  has_many :incomes
  has_many :budgets

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  def transactions # finds all incomes and transactions for a user with type alias, orders by date descending
    transactions = User.find_by_sql("SELECT id, 
                                           amount, 
                                           source, 
                                           date, 
                                           'income' AS type FROM incomes WHERE user_id = #{id} 
                                    UNION 
                                    SELECT id, 
                                           amount, 
                                           category, 
                                           date, 
                                           'expense' AS type FROM expenses WHERE user_id = #{id} 
                                    ORDER BY date DESC")
  end
end
