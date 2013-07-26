module EightPuzzle
  class PuzzleSolver
    def initialize(strategy)
      @strategy = strategy
    end

    def solve
      until @strategy.solved_puzzle
        @strategy.check_next_node
      end
    end

    def print_solution
      solution = []
      puzzle = @strategy.solved_puzzle

      while (puzzle)
        solution << puzzle 
        puzzle = puzzle.parent
      end

      solution.reverse!

      puts "Total Steps: #{solution.count}"
      puts "Nodes Searched: #{@strategy.nodes_searched}"
      puts

      solution.each do |state|
        puts state
        puts
      end
    end
  end
end
