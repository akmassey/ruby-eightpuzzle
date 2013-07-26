module EightPuzzle
  class Puzzle
    attr_reader :state

    def initialize(state)
      @state = state
    end

    def to_s
      @state.to_s
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

      Puzzle.new(create_state_from_move_direction(direction))
    end

    # Performs an in-place move on self based on the direction
    def move!(direction)
      raise "Impossible move" unless moves.include?(direction)

      @state = create_state_from_move_direction(direction)

      self
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
  end
end
