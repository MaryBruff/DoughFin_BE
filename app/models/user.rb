class User < ApplicationRecord
  has_many :expenses
  has_many :incomes

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
end
