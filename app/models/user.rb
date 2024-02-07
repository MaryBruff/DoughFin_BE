class User < ApplicationRecord
  has_many :expenses
  has_many :incomes
  has_many :budgets

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  def transactions # finds all incomes and transactions for a user with type alias, orders by date descending
    transactions = User.find_by_sql("SELECT id,
                                           amount,
                                           source AS category,
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

  # select all incomes, group by month, alias of year, SUM of amount each month
  def years_available # provides a unique list of years available for a user's incomes
    incomes.map do |income|
      income.year
    end.uniq
  end

  def transaction_amounts_by_month_and_year
    User.find_by_sql("SELECT 
                        EXTRACT(YEAR FROM date) AS year,
                        TO_CHAR(date, 'Month') AS month,
                        SUM(amount) AS total_amount,
                        'monthly_income' AS type 
                      FROM incomes
                      WHERE user_id = #{id}
                      GROUP BY year, month
                      UNION
                      SELECT 
                        EXTRACT(YEAR FROM date) AS year,
                        TO_CHAR(date, 'Month') AS month,
                        SUM(amount) AS total_amount,
                        'monthly_expense' AS type 
                      FROM expenses
                      WHERE user_id = #{id}
                      GROUP BY year, month
                      ORDER BY year, month;")
    # select amount and date from income and expenses
    # pull month and year from date and print month as a word
    # create monthly_income and monthly_expenses types column
    # sum amounts on each table
    # union between expenses and incomes where user_id = id
  end
end
