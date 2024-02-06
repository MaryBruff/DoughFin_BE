module Types
  class CurrentExpenseType < Types::BaseObject
    field :amount, Float, null: true
    field :pctChange, Float, null: true
  end
end
