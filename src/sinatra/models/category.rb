class Category < Sequel::Model(:categories)
  one_to_many :transactions, key: :category_id

  # attr_accessor :id, :name

  # def initialize(id:, name:)
  #   @id = id
  #   @name = name
  # end


end
