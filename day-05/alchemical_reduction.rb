require "pry"
#9348
#4496

class AlchemicalReduction
  def initialize
    @results_by_letters = Hash.new
    set_input
  end
  attr_accessor :input, :unfinished, :results_by_letters

  def set_input
    @input = File.read(ARGV[0]).delete("\n").split("")
  end

  def run
    ("a".."z").to_a.each do |letter|
      @unfinished = true
      while unfinished do
        @input.delete_if{ |e| e.match(/#{letter}|#{letter.upcase}/) }
        reduce
      end
      results_by_letters[letter] = @input.size
      p results_by_letters
      set_input
    end
    p @results_by_letters
  end

  def reduce
    @unfinished = false
    @input.each_with_index do |value, index|
      next_value = @input[index + 1]

      if value.swapcase == next_value
        @input[index] = @input[index + 1] = "*"
        @unfinished = true
      end
    end
    @input.delete("*")
  end
end

AlchemicalReduction.new.run
