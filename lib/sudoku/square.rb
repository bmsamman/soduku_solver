module Sudoku
  class Square
    attr_accessor :value, :neighbors
    attr_reader :neighbors, :row, :column, :section

    def initialize index,value=nil
      @index = index
      @neighbors = []
      @value = value
    end

    def possible_values
      (1..9).to_a - neighboring_values
    end

    def neighboring_values
      neighbors.map(&:value).uniq
    end

    def try number
      return false unless valid_value?(number)
      @value = number
    end

    def valid_value? number
      !invalid_value?(number)
    end

    def valid?
      valid_value? value
    end

    def invalid?
      invalid_value? value
    end

    def invalid_value? number
      !!(number.nil? || neighboring_values.include?(number))
    end

    def to_s
      return '-' if value.nil?
      value.to_s
    end

    def row
      @row ||= @index / 9
    end

    def column
      @column ||= @index % 9
    end

    def section
      @section ||= (row / 3)*3 + column/3
    end
  end
end