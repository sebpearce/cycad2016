class Category < Sequel::Model(:categories)
  one_to_many :transactions, key: :category_id
end
