module JSONFormatter
  def self.format_init_payload(entries, categories)
    e = self.format_entries(entries)
    c = self.format_categories(categories)
    {
      'categories': c,
      'entries': e
    }.to_json
  end

  def self.format_with_key(label, a)
    {
      label => a
    }.to_json
  end

  def self.format_entries(entries)
    list_of_days = entries.group_by { |entry| entry[:date] }
    list_of_days.keys.map do |day|
      [
        day,
        list_of_days[day].map do |x|
          x.tap { |t| t.delete(:date) }
        end
      ]
    end
  end

  def self.format_categories(categories)
    categories.map do |item|
      [item[:id], item[:name]]
    end
  end

  def self.format_entries_as_json(entries)
    output = self.format_entries(entries)
    self.format_with_key('entries', output)
  end

  def self.format_categories_as_json(categories)
    output = self.format_categories(categories)
    self.format_with_key('categories', output)
  end

  def self.format_entries_for_one_day(day)
    day_grouped_by_date = day.group_by { |entry| entry[:date] }
    date = day_grouped_by_date.keys[0]
    entries = day_grouped_by_date[date].map do |entry|
      entry.tap { |t| t.delete(:date) }
    end
    [date, entries].to_json
  end
end
