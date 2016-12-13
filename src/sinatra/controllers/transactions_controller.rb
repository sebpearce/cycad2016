require_relative '../models/transaction'
require_relative '../models/category'
require_relative '../services/json_formatter'

class TransactionsController
  def index
    query = Transaction.all
    query.empty? ? "Not found." : JSONFormatter.format_transactions(query.map(&:values))
  end

  def one_day(date)
    query = Transaction.where(date: date).all
    query.empty? ? "Not found." : JSONFormatter.format_transactions(query.map(&:values))
  end

  def range_of_dates(start_date, end_date)
    query = Transaction.where(date: start_date..end_date).all
    query.empty? ? "Not found." : JSONFormatter.format_transactions(query.map(&:values))
  end
end


