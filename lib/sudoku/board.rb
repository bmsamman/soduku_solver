require_relative 'printer'
require_relative 'cell'

module Sudoku
  class Board
    include Printer
    attr_accessor :board, :rows, :columns, :cells, :sections

    def self.build ary
      board = new
      raise 'Array is the wrong size' if ary.size != board.size
      board.cells.each_with_index {|cell, index|  cell.value = ary[i]}
      board
    end

    def initialize(fill_in = 10)
      @fill_in_count = fill_in
      initialize_board
      setup_cells
      fill_initial_cells
    end

    def can_fill cell, value
      return false if has_value? @columns[cell.column], cell, value
      return false if has_value? @rows[cell.row], cell, value
      return false if has_value? @sections[cell.section], cell, value
      true
    end

    def has_value? array, cell,  value
      other_cells = (array - [cell])
      values = other_cells.map(&:value).compact
      values.include? value
    end

    def fill_cell row, column, value,no_print=false
      cell = @board[row][column]
      if can_fill cell, value
        cell.value = value
        return true
      else
        puts 'Value is invalid' unless no_print
        return false
      end
    end

    def empty_cells
      @cells.select{|cell| cell.value.nil?}
    end

    def solved?
      not to_a.include? nil
    end

    def to_a
      @cells.map(&:value)
    end
    private
    def initialize_board
      @cells    = []
      @board    = Hash.new([])
      @rows     = Array.new
      @columns  = Array.new
      @sections = Array.new
    end

    def setup_cells
      81.times.each{|index| add_cell index}
    end

    def add_cell index
      cell = Cell.new(self, index)
      row, column, section = cell.row, cell.column, cell.section

      @cells                <<  cell
      @board[row][column]   =  cell
      (@rows[row] ||= [])           <<  cell
      (@columns[column] ||= [])     << cell
      (@sections[section] ||= [])   <<  cell
    end

    def fill_initial_cells
      @cells.sample(@fill_in_count).each do |cell|
        [*(1..9)].sample(9).each do |value|
          if can_fill cell, value
            cell.value = value
            break
          end
        end
      end
    end

  end
end
