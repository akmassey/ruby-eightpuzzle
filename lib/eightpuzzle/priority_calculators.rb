module EightPuzzle
  module PriorityCalculators
    def out_of_place_priority_calculator
      Proc.new do |node|
        node.state.size - node.tiles_out_of_place
      end
    end

    def manhattan_priority_calculator
      Proc.new do |node|
        0 - node.manhattan_distance
      end
    end

    def hamming_priority_calculator
      Proc.new do |node|
        node.state.size - node.tiles_out_of_place - node.depth
      end
    end
  end
end
