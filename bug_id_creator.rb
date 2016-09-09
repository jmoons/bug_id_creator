class BugIdCreator

  LETTER_RANGE    = ("A" .. "Z")
  NUMBER_RANGE    = ("0" .. "9")
  ARRAY_OF_VALUES = NUMBER_RANGE.to_a.concat(LETTER_RANGE.to_a)

  def initialize(last_generated_value, number_of_values_to_generate)
    @last_generated_value         = last_generated_value
    @number_of_values_to_generate = number_of_values_to_generate
    @out_of_values                = false
    @generated_value_collection   = []
  end

  def generate
    (1 .. @number_of_values_to_generate).each do |iteration|

      break if @out_of_values

      @last_generated_value ? next_value = get_next_value : next_value = "000"

      @generated_value_collection << next_value if next_value

      @last_generated_value = next_value
    end
    @generated_value_collection.each{ |value| puts value}
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
        if (working_index < 0)
          # No further permutations are available, we are out of characters here
          done            = true
          @out_of_values  = true
          return
        end
      end
    end

    working_value_array.join

  end

  def get_next_character(current_character)
    ARRAY_OF_VALUES[ (ARRAY_OF_VALUES.index(current_character) + 1) ]
  end
end

BugIdCreator.new(nil, 46656).generate
# BugIdCreator.new("00", 36).generate
