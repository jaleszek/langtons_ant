class World
  def initialize
    @x = 0
    @y = 0
    @squares = {}
    @compass = Compass.new

  end

  def ant_position
    [@x, @y]
  end

  def at(x,y)
    @squares[key(x,y)] || 'white'
  end

  def move
    if current_color == 'white'
      @compass.turn_right
    else
      @compass.turn_left
    end

    toggle_current_square
    walk_strategy(@compass.current_direction)
  end

  private

  def current_color
    at(@x, @y)
  end

  def walk_strategy(direction)
    eval(WalkStrategy.new.perform(direction))
  end

  def toggle_current_square
    @squares[key(@x,@y)] = 'black'
  end

  def key(x,y)
    "#{x},#{y}"
  end
end

class Compass
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST']

  def initialize
    @direction = 4
  end

  def current_direction
    DIRECTIONS[@direction % 4]
  end

  def turn_right
    @direction += 1
  end

  def turn_left
    @direction -= 1
  end
end

class WalkStrategy
  def perform(direction)
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