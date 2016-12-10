# seed db

# require 'sequel'
# DB = Sequel.connect('sqlite://cycad.db')

puts "Reseeding database..."

DB.drop_table(:transactions, :categories)

DB.create_table(:categories) do
  primary_key :id
  String :name, null: false
end

DB.create_table(:transactions) do
  String :id, primary_key: true
  Integer :date, null: false
  BigDecimal :amount, size: [8,2], null: false
  foreign_key :category_id, :categories, null: false
  String :description
end

transactions = DB[:transactions]
categories = DB[:categories]

categories.insert(id: 1, name: "Rent")
categories.insert(id: 2, name: "Groceries")
categories.insert(id: 3, name: "Eating out")
categories.insert(id: 4, name: "Salary")
categories.insert(id: 5, name: "Partner's salary")
categories.insert(id: 6, name: "Gifts")
transactions.insert(id: "zzzzzzzz0", date: 20161209, amount: 75, category_id: 2)
transactions.insert(id: "23f98j208", date: 20161209, amount: -17.54, category_id: 2)
transactions.insert(id: "20939aj28", date: 20161208, amount: 636, category_id: 3)
transactions.insert(id: "10ajj8218", date: 20161208, amount: -10111.23, category_id: 4)
transactions.insert(id: "10ajj8144", date: 20161207, amount: -71, category_id: 2)
transactions.insert(id: "0019291na", date: 20161207, amount: 4000, category_id: 1)
