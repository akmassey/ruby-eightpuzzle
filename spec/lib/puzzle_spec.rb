require 'spec_helper'

describe "Puzzle" do

  it "should have a state" do
    p = EightPuzzle::Puzzle.new("5674*8321")
    p.state.should_not be nil
  end

  it "should accurately compare states" do
    p = EightPuzzle::Puzzle.new("5674*8321")
    g = EightPuzzle::Puzzle.new(EightPuzzle::GOAL_STATE)
    (p == g).should be false
    (p == p).should be true
    (g == g).should be true
  end

  it "should raise an exception when asked to move in an impossible direction" do
    p = EightPuzzle::Puzzle.new("5*7468321")
    expect{p.move(:up)}.to raise_error
  end

  it "should return a new puzzle that represents a move" do
    p = EightPuzzle::Puzzle.new("5*7468321")
    m = p.move(:down)
    m.should_not eq p
    m.should_not be p
    m.should eq EightPuzzle::Puzzle.new("5674*8321")
  end

  it "should perform an in-place move" do
    p = EightPuzzle::Puzzle.new("5*7468321")
    m = p.move!(:down)
    m.should eq p
    m.should be p
    m.should eq EightPuzzle::Puzzle.new("5674*8321")
  end

  context "the slider" do
    it "should be able to move to any position when centered" do
      p = EightPuzzle::Puzzle.new("5674*8321")
      p.moves.should eq EightPuzzle::MOVES
    end

    it "should not be able to move up when on the top row" do
      p = EightPuzzle::Puzzle.new("5*7468321")
      p.moves.should eq (EightPuzzle::MOVES - Set.new([:up]) )
    end

    it "should not be able to move right when on the right column" do
      p = EightPuzzle::Puzzle.new("57*468321")
      p.moves.should eq (EightPuzzle::MOVES - Set.new([:up, :right]) )
    end

    it "should not be able to move down when on the bottom row" do
      p = EightPuzzle::Puzzle.new("5674283*1")
      p.moves.should eq (EightPuzzle::MOVES - Set.new([:down]) )
    end

    it "should not be able to move left when on the left column" do
      p = EightPuzzle::Puzzle.new("567428*31")
      p.moves.should eq (EightPuzzle::MOVES - Set.new([:down, :left]) )
    end
  end

  context "the goal state" do
    it "should be used to initialize the goal puzzle" do
      g = EightPuzzle::Puzzle.new(EightPuzzle::GOAL_STATE)
      g.state.should eq EightPuzzle::GOAL_STATE
    end

    it "should have the slider in the center of the puzzle" do
      g = EightPuzzle::Puzzle.new(EightPuzzle::GOAL_STATE)
      g.slider_position.should be 5
    end
  end

  context "when the puzzle has parents" do
    it "should have a depth of one if there's only one parent" do
      p = EightPuzzle::Puzzle.new("567428*31")
      r = EightPuzzle::Puzzle.new("567*28431", p)
      r.depth.should eq 1
    end

    it "should have a depth of two if there are two parents" do
      p = EightPuzzle::Puzzle.new("567428*31")
      r = EightPuzzle::Puzzle.new("567*28431", p)
      q = EightPuzzle::Puzzle.new("5672*8431", r)
      q.depth.should eq 2
    end

  end

end
