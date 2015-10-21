module Sudoku
  module Printer

    def print_row row
      str = ''
      row.each_slice(3) do |a|
        str += a.join('  ') + '     '
      end
      puts str
    end

    def print_board
      9.times do |i|
        print_row @rows[i]
        puts if i % 3 == 2
      end
    end
  end
end