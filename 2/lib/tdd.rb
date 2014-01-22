class World
  attr_reader :ant_position
  attr_reader :x, :y

  BLACK = 'black'
  WHITE = 'white'

  def initialize
    @squares = { }
    @x = 0
    @y = 0
    @compass = Compass.new
  end

  def at x, y
    @squares[key(x,y)] || WHITE
  end

  def toggle_color(x,y)
    send('erase_' + at(x,y) + '_square', x, y)
  end

  def move_ant
    c = at(@x,@y)
    toggle_color(@x, @y)

    if c == WHITE
      @compass.turn_right
    else
      @compass.turn_left
    end

    eval(WalkStrategy.perform(@compass.current_direction))
  end

  private

  def erase_black_square(x,y)
    @squares.delete key(x,y)
  end

  def erase_white_square(x,y)
    @squares[key(x,y)] = BLACK
  end

  def key(x,y)
    "#{x},#{y}"
  end
end

class Compass
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST']

  def initialize
    @current_direction = 4
  end

  def current_direction
    DIRECTIONS[@current_direction % 4]
  end

  def turn_right
    @current_direction += 1
  end

  def turn_left
    @current_direction -= 1
  end
end


class WalkStrategy
  def self.perform(direction)
    if direction == 'NORTH'
      '@y += 1'
    elsif direction == 'EAST'
      '@x += 1'
    elsif direction == 'SOUTH'
      '@y -= 1'
    elsif direction == 'WEST'
      '@x -= 1'
    end
  end
end