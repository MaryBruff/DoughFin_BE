class Budget < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :category, presence: true
  validates :month, presence: true
  # Validates the uniqueness of the combination of category and month
  validates :category, uniqueness: {scope: :month, message: "and month combination must be unique"}

  def self.categories
    pluck(:category).uniq
  end

  def pct_remaining
    if amount > 0
      ((amount_remaining / amount) * 100).round(1)
    else
      0
    end
  end

  def amount_remaining
    amount - amount_spent
  end

  private

  def amount_spent
    Expense.where(category: category).sum(:amount)
  end
end
