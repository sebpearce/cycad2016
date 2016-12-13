require_relative '../models/transaction'
require_relative '../models/category'
require_relative '../services/json_formatter'

class CatgoriesController
  def index
    query = Category.all
    query.empty? ? "Not found." : JSONFormatter.format_categories(query.map(&:values))
  end

  def show(id)
    query = Category.filter(id: id).all
    query.nil? ? "Not found." : JSONFormatter.format_categories(query.map(&:values))
  end
end


