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
  # def years_available # provides a unique list of years available for a user's incomes
  #   incomes.map do |income|
  #     income.year
  #   end.uniq
  # end

  # def create_year_months
  #   years = []
  #   transaction_amounts_by_month_and_year.each do |month|
  #     if years.find
  #   end
  # end

  def cashFlows
    amounts = User.find_by_sql("SELECT 
                        EXTRACT(YEAR FROM incomes.date) AS year,
                        TO_CHAR(incomes.date, 'Month') AS month,
                        SUM(incomes.amount) AS total_income,
                        SUM(expenses.amount) AS total_expense
                      FROM incomes
                      FULL JOIN expenses 
                        ON EXTRACT(YEAR FROM expenses.date) = EXTRACT(YEAR FROM incomes.date) 
                        AND EXTRACT(MONTH FROM expenses.date) = EXTRACT(MONTH FROM incomes.date) 
                        AND expenses.user_id = incomes.user_id
                      WHERE incomes.user_id = #{id}
                      GROUP BY year, month
                      ORDER BY year, month;")

    amounts.map do |amount|
      amount.month.strip!
      amount.year.to_i.to_s # why isn't this working? I'm just trying to remove the ".0" from years
    end
    # select amount and date from income and expenses
    # pull month and year from date and print month as a word
    # sum amounts on each table
    # join expenses and incomes where user_id = id and month and yeat match
    amounts
  end
end
