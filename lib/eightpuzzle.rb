require_relative "./eightpuzzle/version"
require_relative "./eightpuzzle/puzzle"
require_relative "./eightpuzzle/moves"
require_relative "./eightpuzzle/puzzle_generator"
require_relative "./eightpuzzle/puzzle_solver"
require_relative "./eightpuzzle/breadth_first_searcher"
require_relative "./eightpuzzle/depth_first_searcher"

require 'set'

module EightPuzzle
  GOAL_STATE = "1238*4765"
end
