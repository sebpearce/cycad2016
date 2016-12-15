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
  content_type :json
end

get '/?' do
  RootController.new.index
end

get '/transactions/?' do
  TransactionsController.new.index
end

get '/transactions/:date1..:date2/?' do
  TransactionsController.new.show_range_of_dates(params[:date1], params[:date2])
end

get '/transactions/:date/?' do
  TransactionsController.new.show_one_day(params[:date])
end

get '/categories' do
  CatgoriesController.new.index
end

get '/categories/:id' do
  CatgoriesController.new.show(params[:id])
end

post '/transactions/new' do
  request.body.rewind
  payload = JSON.parse(request.body.read)
  begin
    TransactionsController.new.create(payload)
  rescue StandardError => error
    status 400
    error.message
  end
end

post '/categories/new' do
  request.body.rewind
  payload = JSON.parse(request.body.read)
  begin
    CatgoriesController.new.create(payload)
  rescue StandardError => error
    status 400
    error.message
  end
end

not_found do
  "404 not found"
end
