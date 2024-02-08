class Budget < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :category, presence: true
  validates :month, presence: true

  def self.categories
    pluck(:category).uniq
  end

  def pct_remaining
    if self.amount > 0
      ((amount_remaining / self.amount) * 100).round(1)
    else
      0
    end
  end

  def amount_remaining
    self.amount - amount_spent
  end

  private
  def amount_spent
    Expense.where(category: self.category).sum(:amount)
  end
end
