class Transaction < Sequel::Model(:transactions)
  many_to_one :category, key: :category_id

  # attr_accessor :id, :date, :amount, :category_id

  # def initialize(id:, date:, amount:, category_id:)
  #   @id = id
  #   @date = date
  #   @amount = amount
  #   @category_id = category_id
  # end

  # def to_hash
  #   {
  #     "id" => @id.to_s,
  #     "date" => @date.to_s,
  #     "amount" => @amount.to_s,
  #     "category_id" => @category_id.to_s
  #   }
  # end
end

