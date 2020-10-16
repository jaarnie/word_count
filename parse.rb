# frozen_string_literal: true

require 'pdf-reader'
require_relative 'output_to_csv.rb'
require_relative 'stopwords.rb'

class Parse
  def initialize
    file_location = './pdf/lotr-fellowship.pdf'
    # file_location = './pdf/test.pdf'
    @pdf = PDF::Reader.new(file_location)
  end

  def start
    words_array = []
    @pdf.pages.each do |page|
      words_array << page.text.split
    end

    remove_words(words_array)
  end

  def remove_words(words_array)
    words_array.flatten!.reject! { |x| $stop_words.include?(x) }
    words_array.each { |x| x.gsub!(/[^A-Za-z0-9\s]/i, '') }

    create_hash(words_array)
  end

  def create_hash(words_array)
    word_count = Hash.new(0).tap { |h| words_array.each { |word| h[word] += 1 } }
    sorted_word_count = word_count.sort_by { |_k, v| v }.reverse

    send_to_output(sorted_word_count)
  end

  def send_to_output(sorted_word_count)
    output = OutputToCsv.new(sorted_word_count)
    output.write_to_csv
  end
end
