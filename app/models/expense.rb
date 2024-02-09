class Expense < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, date: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :category, presence: true

  before_save :downcase_category

  private

  def downcase_category
    self.category = category.downcase
  end
end
