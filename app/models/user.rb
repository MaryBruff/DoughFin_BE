class User < ApplicationRecord
  has_many :expenses
  has_many :incomes
  has_many :budgets

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  def transactions # finds all incomes and transactions for a user with type alias, orders by date descending
    User.find_by_sql("SELECT id,
                             amount,
                             source AS vendor,
                             date,
                             'debited' AS status FROM incomes WHERE user_id = #{id}
                      UNION
                      SELECT id,
                             amount,
                             vendor,
                             date,
                             'credited' AS status FROM expenses WHERE user_id = #{id}
                      ORDER BY date DESC")
  end

  def cash_flows
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
      if amount.total_income.nil?
        amount.total_income = 0
      end

      if amount.total_expense.nil?
        amount.total_expense = 0
      end
    end
    # select amount and date from income and expenses
    # pull month and year from date and print month as a word
    # sum amounts on each table
    # join expenses and incomes where user_id = id and month and yeat match
    amounts
  end
end
