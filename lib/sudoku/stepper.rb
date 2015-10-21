require_relative 'step'
require_relative 'board'

module Sudoku
  class Stepper
    attr_reader :current_step, :board
    def initialize board=Board.new(0)
      @board = board
      @steps = @board.empty_cells.map do |cell|
        Step.new cell
      end
      @current_step = @steps.first
      @current_index = 0
    end

    def stack
      @stack ||= []
    end

    def step
      raise 'No steps to execute' unless current_step
      unless current_step.execute
        @current_step.reset
        return false
      end
      go_to @current_index + 1
    end

    def unstep
      go_to @current_index - 1
    end

    private



    def go_to index
      @current_index = index
      @current_step = @steps[@current_index]
    end
  end
end
