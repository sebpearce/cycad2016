class Transaction
  attr_accessor :id, :date, :amount, :category_id

  def initialize(id:, date:, amount:, category_id:)
    @id = id
    @date = date
    @amount = amount
    @category_id = category_id
  end

  def to_hash
    {
      "id" => @id,
      "date" => @date,
      "amount" => @amount.to_s,
      "category_id" => @category_id
    }
  end
end

