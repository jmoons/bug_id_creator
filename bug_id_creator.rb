class BugIdCreator

  LETTER_RANGE    = ("A" .. "Z")
  NUMBER_RANGE    = ("0" .. "9")
  ARRAY_OF_VALUES = NUMBER_RANGE.to_a.concat(LETTER_RANGE.to_a)

  def initialize(last_generated_value, number_of_values_to_generate)
    @last_generated_value         = last_generated_value
    @number_of_values_to_generate = number_of_values_to_generate
    @out_of_values                = false
  end

  def generate
    (1 .. @number_of_values_to_generate).each do |iteration|

      break if @out_of_values

      @last_generated_value ? next_value = get_next_value : next_value = "000"

      puts next_value.inspect if next_value

      @last_generated_value = next_value
    end
  end

  def get_next_value
    @last_generated_value.upcase
    split_value = @last_generated_value.split(//)

    third_position_candidate_character = get_next_character(split_value[2])
    if third_position_candidate_character
      split_value[2] = third_position_candidate_character
    else
      split_value[2] = ARRAY_OF_VALUES[0]
      second_position_candidate_character = get_next_character(split_value[1])
      if second_position_candidate_character
        split_value[1] = second_position_candidate_character
      else
        split_value[1] = ARRAY_OF_VALUES[0]
        first_position_candidate_character = get_next_character(split_value[0])
        if first_position_candidate_character
          split_value[0] = first_position_candidate_character
        else
          puts "OUT OF VALUES"
          @out_of_values = true
          return
        end
      end
    end

    split_value.join

  end

  def get_next_character(current_character)
    ARRAY_OF_VALUES[ (ARRAY_OF_VALUES.index(current_character) + 1) ]
  end
end

# BugIdCreator.new(nil, 10).generate
BugIdCreator.new("ZZT", 10).generate
