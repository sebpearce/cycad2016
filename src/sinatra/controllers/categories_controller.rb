require_relative '../models/transaction'
require_relative '../models/category'
require_relative '../services/json_formatter'

class CatgoriesController
  def index
    get_category_query(Category.order(:id).all)
  end

  def show(id)
    get_category_query(Category.filter(id: id).all)
  end

  def create(payload)
    data = Helpers.symbolize_keys(payload)
    verify_category_post(data)
    data[:id] = data[:id].to_i
    Category.insert(
      id:   data[:id],
      name: data[:name],
    )
    data.inspect.to_json
  end

  private

  def get_category_query(dataset)
    dataset.empty? ? "Not found." : JSONFormatter.format_categories(dataset.map(&:values))
  end

  def verify_category_post(payload)
    payload.keys.each do |key|
      raise 'Oh no, nil value!' if payload[key].nil?
    end
  end
end

