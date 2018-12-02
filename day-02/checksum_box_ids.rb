class InputFetcher
  def self.run
    File.read(ARGV[0]).split("\n").map { |box_id| box_id.split("") }
  end
end

class ChecksumBoxIds
  def initialize
    @input = InputFetcher.run
    @two_coincidence_count = 0
    @three_coincidence_count = 0
  end
  attr_accessor :two_coincidence_count, :three_coincidence_count, :input

  def run
    input.each do |box_id|
      calculate_letter_coincidence(box_id)
    end
    two_coincidence_count * three_coincidence_count
  end

private

  def calculate_letter_coincidence(box_id)
    repeated_letters = box_id.group_by(&:itself)

    @two_coincidence_count += 1 if repeated_letters.any?{|k, v| v.size == 2}
    @three_coincidence_count += 1 if repeated_letters.any?{|k, v| v.size == 3}
  end
end

class FabricFinder
  def initialize
    @input = InputFetcher.run
  end
  attr_accessor :input

  def run
    input.each_with_index do |box_id, index|
      input[index + 1..-1].each do |compared_id|
        no_match_count = box_id.zip(compared_id).map{|initial_id, compared_id| initial_id != compared_id}.count(&:itself)
        if no_match_count == 1
          calculate_common_letters(box_id, compared_id)
          break
        end
      end
    end
  end

private

  def calculate_common_letters(box_1_id, box_2_id)
    p (box_1_id - (box_1_id - box_2_id)).join
  end
end

ChecksumBoxIds.new.run
FabricFinder.new.run
