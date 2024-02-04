# frozen_string_literal: true

module Types
  class IncomeInputType < Types::BaseInputObject
    argument :user_id, Integer, required: true
    argument :source, String, required: true
    argument :amount, Float, required: true
    argument :date, GraphQL::Types::ISO8601Date, required: true
  end
end
