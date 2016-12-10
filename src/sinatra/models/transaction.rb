class Transaction < Sequel::Model(:transactions)
  many_to_one :category, key: :category_id
end

