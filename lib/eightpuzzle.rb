require_relative "./eightpuzzle/version"
require_relative "./eightpuzzle/puzzle"
require_relative "./eightpuzzle/moves"
require_relative "./eightpuzzle/puzzle_generator"
require_relative "./eightpuzzle/puzzle_solver"
require_relative "./eightpuzzle/breadth_first_searcher"
require_relative "./eightpuzzle/depth_first_searcher"
require_relative "./eightpuzzle/a_star_searcher"
require_relative "./eightpuzzle/priority_calculators"

require 'set'

module EightPuzzle
  GOAL_STATE = "1238*4765"
  TILES = ['*', '1', '2', '3', '4', '5', '6', '7', '8']

  def self.find_goal_row(tile)
    position = GOAL_STATE.index(tile)
    if [0,1,2].include?(position)
      1
    elsif [3,4,5].include?(position)
      2
    else
      3
    end
  end

  def self.find_goal_column(tile)
    position = GOAL_STATE.index(tile)
    if [0,3,6].include?(position)
      1
    elsif [1,4,7].include?(position)
      2
    else
      3
    end
  end
end
