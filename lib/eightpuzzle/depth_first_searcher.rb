module EightPuzzle
  class DepthFirstSearcher < BreadthFirstSearcher

    def initialize(puzzle)
      super(puzzle)
    end

    def open_successors(node)
      nodes_to_add = []

      node.moves.each do |move|
        new_node = node.move(move)
        nodes_to_add << new_node unless @closed.include?(new_node)
      end

      @opened << nodes_to_add.reverse
      @opened.flatten!
    end

  end
end
