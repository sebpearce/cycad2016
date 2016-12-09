require 'sinatra'
require 'sequel'
require 'json'

require_relative 'models/transaction'

DB = Sequel.connect('sqlite://cycad.db')
transactions = DB[:transactions]
categories = DB[:categories]

get '/transactions' do
  transactions.all.to_json
end

# filter by date range
get '/transactions/:date1-:date2' do
  # "You said #{params[:date1]} and #{params[:date2]}."
  transactions.where(date: params[:date1]..params[:date2]).all.to_json
end

# filter by date
get '/transactions/:date' do
  # "You said #{params[:date]}."
  transactions.where(date: params[:date]).all.to_json
end

get '/categories' do
  categories.all.to_json
end

get '/categories/:id' do
  categories.where(id: params[:id]).all.to_json
end

