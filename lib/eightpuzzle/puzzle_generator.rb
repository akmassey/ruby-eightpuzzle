module EightPuzzle
  module PuzzleGenerator
    def self.make_puzzle(moves)
      puzzle = Puzzle.new(GOAL_STATE)

      moves.times do
        valid_moves = puzzle.moves.to_a
        puzzle.move!(valid_moves.sample)
      end

      puzzle
    end

  end
end
