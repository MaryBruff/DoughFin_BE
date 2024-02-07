class Income < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, date: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :source, presence: true
end
