class Expense < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, date: true
end
