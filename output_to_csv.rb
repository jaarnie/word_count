# frozen_string_literal: true

require 'csv'

class OutputToCsv
  def initialize(sorted_word_count)
    @sorted_word_count = sorted_word_count
  end

  def write_to_csv
    CSV.open('word_count.csv', 'wb') do |csv|
      headers = %w[WORD COUNT]
      csv << headers
      @sorted_word_count.each do |k, v|
        csv << [
          k,
          v
        ]
      end
    end
  end
end
