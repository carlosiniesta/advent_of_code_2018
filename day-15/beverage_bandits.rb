require "pry"

class BeverageBandit

  def initialize
    @input = File.read(ARGV[0]).split("\n")
    @characters = []
  end
  attr_accessor :map, :input, :characters

  def run
    create_map
    create_characters
    tick
  end

  def tick
    @characters.sort_by!(&:y).each do |character|
      move(character)
    end
  end

  def move(character)

  end

  def adj_space(position)
  end

private

  def create_map
    @map = input.map{|line| line.split("")}
  end

  def create_characters
    input.each_with_index do |line, index_y|
      line.split("").each_with_index do |space, index_x|
        if ["G", "E"].include?(space)
          @characters << Character.new(index_x, index_y, space)
        end
      end
    end
  end
end

class Character
  def initialize(x, y, type)
    @hp = 200
    @position = [x, y]
    @type = type
  end
  attr_accessor :position

  def x
    position[0]
  end

  def y
    position[1]
  end
end

BeverageBandit.new.run
