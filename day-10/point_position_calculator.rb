require "pry"

class Light
  def initialize(position, velocity)
    @position = position
    @velocity = velocity
  end
  attr_accessor :position, :velocity

  def move
    @position = [@position, @velocity].transpose.map {|e| e.reduce(:+)}
  end

  def x
    @position[0]
  end

  def y
    @position[1]
  end
end

class LightFactory
  def self.run
    File.read(ARGV[0]).split("\n").map do |light_info|
      x, y, vx, vy = light_info.gsub(/[^0-9" "-]/, '').split(" ").map(&:to_i)
      Light.new([x,y], [vx, vy])
    end
  end
end

class MessageForesee
  def initialize
    @lights = LightFactory.run
    @counter = -1
  end

  def initial_grid
  end

  def run
    # 3.times do
    #   tick
    # end
    #
    # paint_grid
    #
    # binding.pry
    # @grid
    smallest_area(Float::INFINITY)

    @lights = LightFactory.run

    @counter.times do
      tick
    end

    paint_grid

    @grid
  end

  def paint_grid
    @grid = Array.new((min_max_y[1] - min_max_y[0]) + 1) { Array.new(((min_max_x[1] - min_max_x[0]) + 1), ' ') }

    @lights.each do |light|
      p light.y - min_max_y.min
      p light.x - min_max_x.min
      @grid[light.y - min_max_y.min][light.x - min_max_x.min] = "#"
    end
  end

  def min_max_x
    @lights.map{|l| l.x }.minmax
  end

  def min_max_y
    @lights.map{|l| l.y }.minmax
  end

  def tick
    @lights.each do |light|
     light.move
    end
  end

  def smallest_area(prev_area)
    area = (min_max_x[1] - min_max_x[0]) * (min_max_y[1] - min_max_y[0])
    tick
    if area <= prev_area
      @counter += 1
      smallest_area(area)
    end
  end
end

MessageForesee.new.run
