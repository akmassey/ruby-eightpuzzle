module EightPuzzle
  class BreadthFirstSearcher
    attr_reader :solved_puzzle, :nodes_searched

    def initialize(puzzle)
      @start = puzzle
      @goal = Puzzle.new(GOAL_STATE)
      @solved_puzzle = nil

      @opened = []
      @opened << @start
      @closed = []
      @nodes_searched = 0
    end

    def nodes_opened
      @opened
    end

    def check_next_node
      node = @opened.shift

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
        @opened << new_node unless @closed.include?(new_node)
      end
    end

  end
end
