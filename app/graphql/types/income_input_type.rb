# frozen_string_literal: true

module Types
  class IncomeInputType < Types::BaseInputObject
    argument :userId, Int, required: true
    argument :source, String, required: true
    argument :amount, Float, required: true
    argument :date, String, required: true
  end
end
