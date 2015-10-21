module Sudoku
  class Cell
    attr_accessor :value
    attr_reader :index

    def initialize board, index
      @board = board
      @index = index
      @value = nil
    end

    def possible_values
      @possible_values ||= calculate
    end

    def calculate
      @possible_values = [*1..9].select{|val| @board.can_fill self, val }
    end

    def try number
      return false unless valid_value? number
      @value = number
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

    def valid_value? value
      @board.can_fill self, value
    end

    def to_s
      return '-' if value.nil?
      value.to_s
    end
  end
end