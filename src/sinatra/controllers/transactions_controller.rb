require 'json'
require 'sinatra'

require_relative '../helpers/helpers'
require_relative '../models/transaction'
require_relative '../models/category'
require_relative '../services/json_formatter'

class TransactionsController
  def index
    get_transaction_query(Transaction.order(:date).all)
  end

  def show_one_day(date)
    get_transaction_query(Transaction.where(date: date).all)
  end

  def show_range_of_dates(start_date, end_date)
    get_transaction_query(Transaction.where(date: start_date..end_date).order(:date).all)
  end

  def create(payload)
    data = Helpers.symbolize_keys(payload)
    verify_transaction_post(data)
    data[:date] = data[:date].to_i
    data[:category_id] = data[:category_id].to_i
    data[:amount] = BigDecimal(data[:amount])
    Transaction.insert(
      id:          data[:id],
      date:        data[:date],
      amount:      data[:amount],
      category_id: data[:category_id],
      description: data[:description],
    )
    data.inspect
  end

  private

  def get_transaction_query(dataset)
    dataset.empty? ? "Not found." : JSONFormatter.format_transactions(dataset.map(&:values))
  end

  def verify_transaction_post(payload)
    keys = payload.keys - [:description]
    keys.each do |key|
      raise 'Oh no, nil value!' if payload[key].nil?
    end
  end
end


