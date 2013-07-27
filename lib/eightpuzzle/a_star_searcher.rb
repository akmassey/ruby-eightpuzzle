require 'algorithms'

module EightPuzzle
  class AStarSearcher
    attr_reader :solved_puzzle, :nodes_searched

    def initialize(puzzle, priority_calculator=nil)
      @start = puzzle
      @priority_calculator = priority_calculator
      @goal = Puzzle.new(GOAL_STATE)
      @solved_puzzle = nil

      @opened = Containers::PriorityQueue.new
      @opened.push(@start, @start.state.size)
      @closed = []
      @nodes_searched = 0
    end

    def nodes_opened
      @opened.size
    end

    def check_next_node
      node = @opened.pop

      if @closed.include?(node)
        return false
      else
        @closed << node
        @nodes_searched += 1
      end

      if node == @goal
        @solved_puzzle = node
        return true
      end

      open_successors(node)

      return false
    end

    def open_successors(node)
      node.moves.each do |move|
        new_node = node.move(move)
        unless @closed.include?(new_node)
          @opened.push(new_node, @priority_calculator.call(new_node))
        end
      end
    end

    def calculate_a_star_priority(node)
      node.state.size - node.tiles_out_of_place
    end

  end
end
