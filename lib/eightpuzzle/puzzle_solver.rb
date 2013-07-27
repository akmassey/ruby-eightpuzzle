module EightPuzzle
  class PuzzleSolver
    def initialize(strategy)
      @strategy = strategy
      @solution = nil
    end

    def solve
      until @strategy.solved_puzzle
        @strategy.check_next_node
      end
    end

    def solved?
      @strategy.solved_puzzle ? true : false
    end

    def solution
      return nil unless solved?
      return @solution if @solution

      str = ""
      solution = []
      puzzle = @strategy.solved_puzzle

      while (puzzle)
        solution << puzzle
        puzzle = puzzle.parent
      end

      solution.reverse!

      str += "Total Steps: #{solution.count}\n"
      str += "Nodes Searched: #{@strategy.nodes_searched}\n\n"

      solution.each do |state|
        str += "#{state}\n\n"
      end

      @solution = str
    end
  end
end
