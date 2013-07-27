require_relative './priority_calculators'

module EightPuzzle
  class Puzzle
    extend EightPuzzle::PriorityCalculators

    attr_reader :state, :parent

    def initialize(state, parent=nil)
      @state = state
      @parent = parent
    end

    def to_s
      @state[0..2] + "\n" + @state[3..5] + "\n" + @state[6..8]
    end

    def to_pretty_string
      string =  "+---+---+---+\n"
      string += "| #{state[0]} | #{state[1]} | #{state[2]} |\n"
      string +=  "+---+---+---+\n"
      string += "| #{state[3]} | #{state[4]} | #{state[5]} |\n"
      string +=  "+---+---+---+\n"
      string += "| #{state[6]} | #{state[7]} | #{state[8]} |\n"
      string +=  "+---+---+---+\n"
    end

    def ==(other)
      if self.equal?(other)
        true
      elsif other.kind_of?(self.class)
        self.state == other.state
      else
        false
      end
    end

    def slider_position
      @state.index('*') + 1
    end

    def moves
      possible_moves = EightPuzzle::MOVES

      # check verticle moves
      if slider_position < 4
        possible_moves -= Set.new([:up])
      elsif slider_position > 6
        possible_moves -= Set.new([:down])
      end

      # check horizontal moves
      if [1, 4, 7].include? slider_position
        possible_moves -= Set.new([:left])
      elsif [3, 6, 9].include? slider_position
        possible_moves -= Set.new([:right])
      end

      possible_moves
    end

    # Returns a new puzzle reprepsenting the state after making a move
    def move(direction)
      raise "Impossible move" unless moves.include?(direction)

      Puzzle.new(next_state_from_move(direction), self)
    end

    # Performs an in-place move on self based on the direction
    def move!(direction)
      raise "Impossible move" unless moves.include?(direction)

      @state = next_state_from_move(direction)

      self
    end

    def tiles_out_of_place
      tiles = 0

      for i in 0..8
        tiles +=1 if EightPuzzle::GOAL_STATE[i] != @state[i]
      end

      tiles
    end

    def manhattan_distance
      heuristic_value = 0

      EightPuzzle::TILES.each do |t|
        heuristic_value += (find_row(t) - EightPuzzle.find_goal_row(t)).abs
        heuristic_value += (find_column(t) - EightPuzzle.find_goal_column(t)).abs
      end

      heuristic_value
    end

    def depth
      depth = 0
      tmp = @parent

      while tmp
        depth += 1
        tmp = tmp.parent
      end

      depth
    end

    private

    def next_state_from_move(direction)
      new_state = @state.clone
      slider_index = @state.index('*')

      case direction
      when :up
        new_state[slider_index] = @state[slider_index - 3]
        new_state[slider_index - 3] = '*'
      when :down
        new_state[slider_index] = @state[slider_index + 3]
        new_state[slider_index + 3] = '*'
      when :left
        new_state[slider_index] = @state[slider_index - 1]
        new_state[slider_index - 1] = '*'
      when :right
        new_state[slider_index] = @state[slider_index + 1]
        new_state[slider_index + 1] = '*'
      end

      new_state
    end

    def find_position(tile)
      @state.index(tile) + 1
    end

    def find_row(tile)
      position = @state.index(tile)
      if [0,1,2].include?(position)
        1
      elsif [3,4,5].include?(position)
        2
      else
        3
      end
    end

    def find_column(tile)
      position = @state.index(tile)
      if [0,3,6].include?(position)
        1
      elsif [1,4,7].include?(position)
        2
      else
        3
      end
    end

  end
end
