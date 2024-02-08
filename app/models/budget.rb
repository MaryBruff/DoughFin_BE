class Budget < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :category, presence: true
  validates :month, presence: true

  before_save :downcase_category

  private

  def downcase_category
    self.category = category.downcase
  end

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
