module Sudoku
  class Step
    attr_reader :possible_values, :initial_possible_values,
                :cell, :initial_value
    def initialize cell
      @cell = cell
      @initial_value = cell.value
      @initial_possible_values = @cell.possible_values
      @possible_values = @initial_possible_values
    end

    def execute
      return false if valid?
      until(not_valid?)
        break if @cell.try @possible_values.shift
      end
    end

    def valid?
      @possible_values.any?
    end

    def not_valid?
      not valid?
    end

    def reset
      @cell.value = @initial_value
      @possible_values = @initial_possible_values
    end

    def recalculate
      @cell.calculate
      @possible_values = @cell.possible_values
    end

    def done?
      @done
    end
  end
end