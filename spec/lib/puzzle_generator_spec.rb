require 'spec_helper'

describe "Puzzle Generator" do 
  it "should return a puzzle representing the goal state when no moves are provided" do 
    p = EightPuzzle::PuzzleGenerator.make_puzzle(0)
    g = EightPuzzle::Puzzle.new(EightPuzzle::GOAL_STATE)
    p.should eq g
  end

  it "should return a puzzle other than the goal state when 200 moves are provided" do 
    p = EightPuzzle::PuzzleGenerator.make_puzzle(200)
    g = EightPuzzle::Puzzle.new(EightPuzzle::GOAL_STATE)
    p.should_not eq g
  end
end
