
def reload_board
  dir = File.join(File.dirname(__FILE__), 'sudoku', '*')
  Dir[dir].each do |file|
    load file
  end
end

def board
  @board ||= Sudoku::Board.new(0)
end

def solver
  @solver ||= Sudoku::Solver.new board
end

def reload_sudoku
  load './sudoku.rb'
  @board  = Sudoku::Board.new(0)
  @solver = Sudoku::Solver.new board
end

def pb
  board.print_board
end

def fill_random_cell
  cell = board.empty_cells.sample
  cell.value = cell.possible_values.sample
end

def print_possible_values
  board.empty_cells.map &:possible_values
end

def find_solved
  until @board.solved?
    @board = Sudoku::Board.new 81
    sleep 0.5
    pb
    puts '='*80
  end
end

reload_board