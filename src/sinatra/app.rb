require 'sinatra'
require 'sequel'
require 'json'
require 'bigdecimal'

DB = Sequel.connect('sqlite://cycad.db')

require_relative 'seed'
require_relative 'models/transaction'
require_relative 'models/category'
require_relative 'helpers/helpers'
require_relative 'services/json_formatter'
require_relative 'controllers/root_controller'
require_relative 'controllers/transactions_controller'
require_relative 'controllers/categories_controller'

options "*" do
  response.headers["Access-Control-Allow-Methods"] = "GET,PUT,POST,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

before do
  headers 'Access-Control-Allow-Origin' => '*'
end

get '/?' do
  content_type :json
  RootController.new.index
end

get '/transactions/?' do
  content_type :json
  TransactionsController.new.index
end

get '/transactions/:date1..:date2/?' do
  content_type :json
  TransactionsController.new.range_of_dates(params[:date1], params[:date2])
end

get '/transactions/:date/?' do
  content_type :json
  TransactionsController.new.one_day(:date)
end

get '/categories/?' do
  content_type :json
  CatgoriesController.new.index
end

get '/categories/:id/?' do
  content_type :json
  CatgoriesController.new.show(params[:id])
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

post '/transactions/new' do
  request.body.rewind
  payload = JSON.parse(request.body.read)
  data = Helpers.symbolize_keys(payload)

  begin
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
  rescue StandardError => error
    status 400
    error.message
  else
  end
end

post '/categories/new' do
  request.body.rewind
  payload = JSON.parse(request.body.read)
  data = Helpers.symbolize_keys(payload)
  begin
    verify_category_post(data)
    data[:id] = data[:id].to_i
    Category.insert(
      id:   data[:id],
      name: data[:name],
    )
  rescue StandardError => error
    status 400
    error.message
  else
    data.inspect
  end
end

not_found do
  content_type :json
  "404 not found"
end
