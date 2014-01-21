require 'colorize'

class World
  def initialize
    @squares = { }
  end

  def at(x, y)
    if  v = @squares[key(x,y)]
      v
    else
      'white'
    end
  end

  def squares
    @squares
  end

  def toggle_square(x, y)
    @squares ||= {}

    k = key(x,y)
    if @squares[k] == 'black'
      @squares.delete(k)
    else
      @squares[k] = 'black'
    end
  end

  private

  def key(x,y)
    "#{x}.#{y}"
  end
end 

class Ant

  def initialize(world)
    initialize_position
    @world = world
    @compass = AntCompass.new
  end

  attr_reader :x, :y

  def move
    current_color = @world.at(x,y)
    @world.toggle_square(x,y)

    @compass.for_int_direction( ( current_color == 'white' ?  1 : -1) )
    eval(AntWalkStrategy.walk(@compass.current_direction))
  end

  private

  def initialize_position
    @x = 0
    @y = 0
  end
end

class AntCompass
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST']

  def initialize
    @current_index  = 4
  end

  def for_int_direction(int_direction)
    if int_direction == -1
      turn_left
    elsif int_direction == 1
      turn_right
    end
  end

  def current_direction
    DIRECTIONS[@current_index%4]
  end  

  def turn_right
    @current_index += 1
  end

  def turn_left
    @current_index -= 1
  end
end

class AntWalkStrategy
  MAPPING = {
    'NORTH' => '@y += 1',
    'EAST' => '@x += 1',
    'SOUTH' => '@y -= 1',
    'WEST' => '@x -= 1'
  }

  def self.walk(direction)
    MAPPING[direction]
  end
end

class WorldPrinter
  def initialize(world)
    @world = world
    @extracted_world = @world.map do |coordinates, color|
      x,y = coordinates.split('.').map(&:to_i)
      [x,y,color]
    end
  end

  def print
    if @world == {}
      "000\n0n0\n000"
    else
      require 'matrix'
      matrix = Matrix.zero(70)

      @extracted_world.each do |x,y,color|
        matrix.send(:[]=, 50-y, 50+x, "B".red)
      end
      matrix.to_a.join_matrix
    end
  end
end

class Array
  def join_matrix
    res = ""
    self.each do |row|
      res += (row.join + "\n")
    end
    res
  end
end

world = World.new
ant = Ant.new(world)
12500.times{ ant.move }

puts WorldPrinter.new(world.squares).print