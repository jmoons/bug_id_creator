class BugIdCreator

  attr_reader :generated_value_collection

  LETTER_RANGE    = ("A" .. "Z")
  NUMBER_RANGE    = ("0" .. "9")
  ARRAY_OF_VALUES = NUMBER_RANGE.to_a.concat(LETTER_RANGE.to_a)

  def initialize(last_generated_value, number_of_values_to_generate)
    @last_generated_value         = last_generated_value
    @number_of_values_to_generate = number_of_values_to_generate
    @generated_value_collection   = []

    generate
  end

  def print_collection
    @generated_value_collection.each{ |value| puts value}
  end

  private

  def generate
    (1 .. @number_of_values_to_generate).each do |iteration|

      @last_generated_value ? next_value = get_next_value : next_value = "000"

      # If next_value is nil, we have reached the end of all possible values
      break unless next_value

      @generated_value_collection << next_value

      @last_generated_value = next_value

    end

  end

  def get_next_value
    working_value       = @last_generated_value.upcase
    working_value_array = working_value.split(//)
    working_index       = working_value_array.length - 1
    done                = false

    while !done do
      candidate_character = get_next_character( working_value_array[working_index] )
      if candidate_character
        # No rollover needed
        working_value_array[working_index] = candidate_character
        done = true
      else
        # Value roll-over
        working_value_array[working_index] = ARRAY_OF_VALUES[0]
        working_index -= 1

        # If working index is negative, we have no
        # further permutations available, we are out of characters here
        return if (working_index < 0)

      end
    end

    working_value_array.join

  end

  def get_next_character(current_character)
    ARRAY_OF_VALUES[ (ARRAY_OF_VALUES.index(current_character) + 1) ]
  end
end

BugIdCreator.new(nil, 46658).print_collection
# BugIdCreator.new("00", 36).print_collection
