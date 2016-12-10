module JSONFormatter
  def self.prepare_transactions(transactions)
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

  def self.prepare_categories(categories)
    if categories.size > 1
      categories.map do |item|
        [item[:id], item[:name]]
      end
    else
      [categories.first[:id], categories.first[:name]]
    end
  end

  def self.format_init_payload(transactions, categories)
    e = self.prepare_transactions(transactions)
    c = self.prepare_categories(categories)
    {
      'categories': c,
      'transactions': e
    }.to_json
  end

  def self.format_transactions(transactions)
    self.prepare_transactions(transactions).to_json
  end

  def self.format_categories(categories)
    self.prepare_categories(categories).to_json
  end
end
