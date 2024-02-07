class Income < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, date: true
end
