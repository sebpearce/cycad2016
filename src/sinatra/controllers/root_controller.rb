require_relative '../models/transaction'
require_relative '../models/category'
require_relative '../services/json_formatter'

class RootController
  def index
    transactions_query = Transaction.order(:date).all.map(&:values)
    categories_query = Category.all.map(&:values)
    if transactions_query.empty? || categories_query.empty?
      "Failed to load initial state."
    else
      JSONFormatter.format_init_payload(transactions_query, categories_query)
    end
  end
end
