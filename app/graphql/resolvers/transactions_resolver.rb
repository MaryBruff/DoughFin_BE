module Resolvers
  class TransactionsResolver < Resolvers::BaseResolver
    ## allows for optional additional queries such as month and category
    argument :month, String, required: false
    argument :category, String, required: false

    type [Types::TransactionType], null: false

    def resolve(month: nil, category: nil)
      ## defaults as nil for both argument parameters and determines the proper response
      if month.present? && category.present?
        object.transactions.where(month: month, category: category)
      else
        object.transactions
      end
    end
  end
end