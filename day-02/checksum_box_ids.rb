require "pry"

class ChecksumBoxIds
  def initialize
    @two_coincidence_count = 0
    @three_coincidence_count = 0
  end
  attr_accessor :two_coincidence_count, :three_coincidence_count

  def run
    input = File.read(ARGV[0])

    input.split("\n").each do |box_id|
      calculate_letter_coincidence(box_id)
    end
    p two_coincidence_count * three_coincidence_count
  end

private

  def calculate_letter_coincidence(box_id)
    repeated_letters = box_id.split("").group_by(&:itself)

    @two_coincidence_count += 1 if repeated_letters.any?{|k, v| v.size == 2}
    @three_coincidence_count += 1 if repeated_letters.any?{|k, v| v.size == 3}
  end
end

ChecksumBoxIds.new.run
