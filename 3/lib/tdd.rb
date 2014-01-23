class World

  def initialize
    @x = 0
    @y = 0
    @squares = {}
    @compass = WalkingStrategy.new
  end

  def at(x,y)
    @squares[key(x,y)] || 'white'
  end

  def ant_position
    [@x, @y]
  end

  def move
    if at(@x,@y) == 'white'
      toggle_current_square_color
      @compass.move_right
      eval(@compass.perform_representation)
    else
      toggle_current_square_color
      @compass.move_left
      eval(@compass.perform_representation)
    end
  end

  private

  def toggle_current_square_color
    color = at(@x,@y)

    if color == 'white'
      @squares[key(@x,@y)] = 'black'
    else
      @squares.delete(key(@x,@y))
    end
  end

  def key(x,y)
    "#{x},#{y}"
  end
end


class WalkingStrategy
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST']

  def initialize
    @current_direction_index = 4
  end

  def current_direction
    DIRECTIONS[@current_direction_index % 4]
  end

  def move_right
    @current_direction_index += 1
  end

  def move_left
    @current_direction_index -= 1
  end

  def perform_representation
    if current_direction == 'NORTH'
      '@y += 1'
    elsif current_direction == 'EAST'
      '@x += 1'
    elsif current_direction == 'SOUTH'
      '@y -= 1'
    elsif current_direction == 'WEST'
      '@x -= 1'
    end
  end
end