require_relative 'stepper'

module Sudoku
  class Solver
    attr_accessor :board
    def initialize board=Board.new(0)
      @board = board
    end

    def solve_with_stepper

    end

    def solve
      solve_with_brute_force
    end

    def solve_with_brute_force
      fill_section @board.sections[0]
      fill_section @board.sections[4]
      fill_section @board.sections[8]
      fill_easy_cells
      [*0..8].each do |index|
        fill_cells @board.rows[index]
        fill_easy_cells
        fill_cells @board.columns[index]
        fill_easy_cells
      end
    end

    def fill_cells cells
      [*cells].each do |cell|
        next unless cell.value.nil?
        cell.value = cell.possible_values.sample
      end
    end

    def fill_easy_cells
      empty_cells = 0
      until empty_cells == @board.empty_cells
        empty_cells = @board.empty_cells
        fill_cells_with_single_possible_value
      end
    end

    def fill_cells_with_single_possible_value
      @board.empty_cells.each do |cell|
        if cell.possible_values.size == 1
          cell.value = cell.possible_values.first
        end
      end
    end

    def find_single_possible_values
       @board.empty_cells.select do |cell|
        cell.possible_values.size == 1
      end
    end

    def fill_section section
      numbers = (1..9).to_a.sample(9)
      section.each_with_index do |cell,index|
        fill_cell cell, numbers[index]
      end
    end

    def fill_cell cell, value,no_print=false
      if can_fill cell, value
        cell.value = value
        return true
      else
        puts 'Value is invalid' unless no_print
        return false
      end
    end

    def fill_cell_at row,column, value,no_print=false
      cell = @board.board[row][column]
      if can_fill cell, value
        cell.value = value
        return true
      else
        puts 'Value is invalid' unless no_print
        return false
      end
    end

    def can_fill cell, value
      return false if has_value? @board.columns[cell.column], cell, value
      return false if has_value? @board.rows[cell.row], cell, value
      return false if has_value? @board.sections[cell.section], cell, value
      true
    end

    def has_value? array, cell,  value
      other_cells = (array - [cell])
      values = other_cells.map(&:value).compact
      values.include? value
    end
  end
end