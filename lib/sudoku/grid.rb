require_relative 'printer'
require_relative 'cell'

module Sudoku
  class Grid
    include Printer
    attr_accessor :grid, :rows, :columns, :cells, :sections

    def self.build ary
      grid = new
      raise 'Array is the wrong size' if ary.size != grid.size
      grid.cells.each_with_index {|cell, index|  cell.value = ary[i]}
      grid
    end

    def initialize(fill_in = 10)
      @fill_in_count = fill_in
      initialize_grid
      setup_cells
      fill_initial_cells
    end

    def fill_cell row, column, value,no_print=false
      cell = @grid[row][column]
      if cell.valid_value? value
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
    def initialize_grid
      @cells    = []
      @grid    = Hash.new([])
      @rows     = Array.new
      @columns  = Array.new
      @sections = Array.new
    end

    def setup_cells
      81.times.each{|index| add_cell index}
      introduce_neighbors
    end

    def introduce_neighbors
      @cells.each do |cell|
        neighbors = @rows[cell.row] + @columns[cell.column] + @sections[cell.section]
        cell.neighbors = neighbors.uniq - cell
      end
    end

    def add_cell index
      cell = Square.new(index)
      row, column, section = cell.row, cell.column, cell.section

      @cells                <<  cell
      @grid[row][column]   =  cell
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
