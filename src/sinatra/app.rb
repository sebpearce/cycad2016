require 'sinatra'
require 'sequel'
require 'json'
require 'bigdecimal'

DB = Sequel.connect('sqlite://cycad.db')

# require_relative 'seed'
require_relative 'models/transaction'
require_relative 'models/category'
require_relative 'helpers/json_formatter'

get '/?' do
  content_type :json
  transactions_query = Transaction.all.map(&:values)
  categories_query = Category.all.map(&:values)
  if transactions_query.empty? || categories_query.empty?
    "Failed to load initial state."
  else
    JSONFormatter.format_init_payload(transactions_query, categories_query)
  end
end

get '/transactions/?' do
  content_type :json
  query = Transaction.all
  query.empty? ? "Not found." : JSONFormatter.format_transactions(query.map(&:values))
end

get '/transactions/:date1..:date2/?' do
  content_type :json
  query = Transaction.where(date: params[:date1]..params[:date2]).all
  query.empty? ? "Not found." : JSONFormatter.format_transactions(query.map(&:values))
end

get '/transactions/:date/?' do
  content_type :json
  query = Transaction.where(date: params[:date]).all
  query.empty? ? "Not found." : JSONFormatter.format_transactions(query.map(&:values))
end

get '/categories/?' do
  content_type :json
  query = Category.all
  query.empty? ? "Not found." : JSONFormatter.format_categories(query.map(&:values))
end

get '/categories/:id/?' do
  content_type :json
  query = Category.filter(id: params[:id]).all
  query.nil? ? "Not found." : JSONFormatter.format_categories(query.map(&:values))
end

def verify_transaction_post(payload)
  keys = payload.keys - [:description]
  keys.each do |key|
    raise 'Oh no, nil value!' if payload[key].nil?
  end
end

def verify_category_post(payload)
  payload.keys.each do |key|
    raise 'Oh no, nil value!' if payload[key].nil?
  end
end

def symbolize_keys(hash)
  Hash[hash.map{ |k,v| [k.to_sym, v] }]
end

post '/transactions/new' do
  request.body.rewind
  payload = JSON.parse(request.body.read)
  data = symbolize_keys(payload)

  begin
    verify_transaction_post(data)
    data[:date] = data[:date].to_i
    data[:category_id] = data[:category_id].to_i
    data[:amount] = BigDecimal(data[:amount])
  rescue RuntimeError => error
    error.message
  else
    # TODO: Handle DB errors like NOT NULL constraint
    Transaction.insert(
      id:          data[:id],
      date:        data[:date],
      amount:      data[:amount],
      category_id: data[:category_id],
      description: data[:description],
    )
  end
end

post '/categories/new' do
  request.body.rewind
  payload = JSON.parse(request.body.read)
  data = symbolize_keys(payload)
  begin
    verify_category_post(data)
    data[:id] = data[:id].to_i
  rescue RuntimeError => error
    error.message
  else
    data.inspect
  end
end

not_found do
  content_type :json
  "404 not found"
end
