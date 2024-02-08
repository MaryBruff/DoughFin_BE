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
end
