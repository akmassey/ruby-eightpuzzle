require 'spec_helper'

describe "PuzzleSolver" do

  let(:puzzle) { EightPuzzle::Puzzle.new("8132*4765") }
  let(:standard_a_star) { EightPuzzle::AStarSearcher.new(puzzle, EightPuzzle::Puzzle.out_of_place_priority_calculator) }

  it "should initialize with a strategy" do
    ps = EightPuzzle::PuzzleSolver.new(1)
    ps.should_not be nil
  end

  it "should be able to solve a puzzle" do
    ps = EightPuzzle::PuzzleSolver.new(standard_a_star)
    ps.solve
    ps.solved?.should be true
  end

  it "should save a string describing the solution" do 
    ps = EightPuzzle::PuzzleSolver.new(standard_a_star)
    ps.solve
    ps.solution.class.should be String
    ps.solution.size.should > 0
  end
end
