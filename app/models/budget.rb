class Budget < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :category, presence: true
  validates :month, presence: true
  validates :flow, presence: true

  def self.categories
    pluck(:category).uniq
  end
end
