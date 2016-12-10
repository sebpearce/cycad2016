class JSONFormatter
  class << self
    def format_init_payload(transactions, categories)
      e = prepare_transactions(transactions)
      c = prepare_categories(categories)
      {
        'categories': c,
        'transactions': e
      }.to_json
    end

    def format_transactions(transactions)
      prepare_transactions(transactions).to_json
    end

    def format_categories(categories)
      prepare_categories(categories).to_json
    end

    private

    def prepare_transactions(transactions)
      list_of_days = transactions.group_by { |transaction| transaction[:date] }

      if list_of_days.size > 1
        list_of_days.keys.map do |day|
          [
            day,
            list_of_days[day].map do |x|
              x.tap { |t| t.delete(:date) }
            end
          ]
        end
      else
        date = list_of_days.keys[0]
        list_of_days[date].map do |transaction|
          transaction.tap { |t| t.delete(:date) }
        end
      end
    end

    def prepare_categories(categories)
      if categories.size > 1
        categories.map do |item|
          [item[:id], item[:name]]
        end
      else
        [categories.first[:id], categories.first[:name]]
      end
    end
  end
end
