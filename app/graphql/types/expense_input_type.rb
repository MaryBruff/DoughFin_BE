# frozen_string_literal: true

module Types
  class ExpenseInputType < Types::BaseInputObject
    argument :userId, Int, required: true
    argument :vendor, String, required: true
    argument :category, String, required: true
    argument :amount, Float, required: true
    argument :nature, String, required: true
    argument :date, String, required: true
  end
end
