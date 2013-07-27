module EightPuzzle
  class Puzzle
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

      Puzzle.new(create_state_from_move_direction(direction), self)
    end

    # Performs an in-place move on self based on the direction
    def move!(direction)
      raise "Impossible move" unless moves.include?(direction)

      @state = create_state_from_move_direction(direction)

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

      position = find_position('1')
      if (position == 1)
        heuristic_value += 0
      elsif (position == 2 or position == 4)
        heuristic_value += 1
      elsif (position == 3 or position == 5 or position == 7)
        heuristic_value += 2
      elsif (position == 6 or position == 8)
        heuristic_value += 3
      elsif (position == 9)
        heuristic_value += 4
      end

      position = find_position('2')
      if (position == 2)
        heuristic_value += 0
      elsif (position == 1 or position == 3 or position == 5)
        heuristic_value += 1
      elsif (position == 4 or position == 6 or position == 8)
        heuristic_value += 2
      elsif (position == 7 or position == 9)
        heuristic_value += 3
      end

      position = find_position('3')
      if (position == 3)
        heuristic_value += 0
      elsif (position == 2  or position == 6)
        heuristic_value += 1
      elsif (position == 1 or position == 5 or position == 9)
        heuristic_value += 2
      elsif (position == 4  or position == 8)
        heuristic_value += 3
      elsif (position == 7)
        heuristic_value += 4
      end

      position = find_position('8')
      if (position == 4)
        heuristic_value += 0
      elsif (position == 1 or position == 7 or position == 5)
        heuristic_value += 1
      elsif (position == 2 or position == 8 or position == 6)
        heuristic_value += 2
      elsif (position == 3 or position == 9)
        heuristic_value += 3
      end

      position = find_position('*')
      if( position == 5 )
        heuristic_value += 0
      elsif (position == 2 or position == 4 or position == 6 or position == 8)
        heuristic_value += 1
      elsif (position == 1 or position == 3 or position == 7 or position == 9)
        heuristic_value += 2
      end

      position = find_position('4')
      if (position == 6)
        heuristic_value += 0
      elsif (position == 3 or position == 5 or position == 9)
        heuristic_value += 1
      elsif (position == 2 or position == 8 or position == 4)
        heuristic_value += 2
      elsif (position == 1 or position == 7)
        heuristic_value += 3
      end

      position = find_position('7')
      if (position == 7)
        heuristic_value += 0
      elsif (position == 4 or position == 8)
        heuristic_value += 1
      elsif (position == 1 or position == 5 or position == 9)
        heuristic_value += 2
      elsif (position == 2 or position == 6)
        heuristic_value += 3
      elsif (position == 3)
        heuristic_value += 4
      end

      position = find_position('6')
      if (position == 8)
        heuristic_value += 0
      elsif (position == 5 or position == 7 or position == 9)
        heuristic_value += 1
      elsif (position == 4 or position == 2 or position == 6)
        heuristic_value += 2
      elsif (position == 1 or position == 3)
        heuristic_value += 3
      end

      position = find_position('5')
      if (position == 9)
        heuristic_value += 0
      elsif (position == 8 or position == 6)
        heuristic_value += 1
      elsif (position == 3 or position == 5 or position == 7)
        heuristic_value += 2
      elsif (position == 2 or position == 4)
        heuristic_value += 3
      elsif (position == 1)
        heuristic_value += 4
      end

      heuristic_value
    end

    private

    def create_state_from_move_direction(direction)
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

      return new_state
    end

    def find_position(tile)
      @state.index(tile) + 1
    end

  end
end
