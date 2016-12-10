require 'sinatra'
require 'sequel'
require 'json'

DB = Sequel.connect('sqlite://cycad.db')

require_relative 'seed'
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
  query.empty? ? "Not found." : JSONFormatter.format_entries_as_json(query.map(&:values))
end

get '/transactions/:date1-:date2' do
  content_type :json
  query = Transaction.where(date: params[:date1]..params[:date2]).all
  query.empty? ? "Not found." : JSONFormatter.format_entries_as_json(query.map(&:values))
end

get '/transactions/:date' do
  content_type :json
  query = Transaction.where(date: params[:date]).all
  query.empty? ? "Not found." : JSONFormatter.format_entries_for_one_day(query.map(&:values))
end

get '/categories/?' do
  content_type :json
  query = Category.all
  query.empty? ? "Not found." : JSONFormatter.format_categories_as_json(query.map(&:values))
end

get '/categories/:id' do
  content_type :json
  query = Category.filter(id: params[:id]).first
  query.nil? ? "Not found." : query.values.to_json
end

not_found do
  content_type :json
  "404 not found"
end
