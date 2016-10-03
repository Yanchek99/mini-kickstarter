# A validator for credit card numbers using the luhn-10 algorithm
# https://en.wikipedia.org/wiki/Luhn_algorithm
class LuhnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is invalid') unless luhn_valid?(value)
  end

  private

  def luhn_valid?(number)
    digits_array = split_to_array(number)
    # The last digit of the number is the check digit
    check_digit = digits_array.pop # pop so it is not used in aquiring checksum
    check_digit == checksum(digits_array)
  end

  # Takes an array of digits from a card number, and produces a checksum using
  # the luhn algorithm
  def checksum(digits_array)
    # reverse the array , and iterate through the array.
    total = digits_array.reverse.each_with_index.inject(0) do |sum, (digit, index)|
      # Add digits together, doubling every other (even indexs)
      # Use sum_of_digits to sum the digits for products > 9
      sum + sum_of_digits(index.even? ? digit * 2 : digit)
    end

    checksum = 10 - (total % 10)
    checksum == 10 ? 0 : checksum
  end

  # Returns the sum of all the digits in a number
  # Ex. sum_of_digits(321) returns 6
  def sum_of_digits(number)
    split_to_array(number).inject(:+)
  end

  # Takes a number and puts into an array
  # Ex. split_to_array(1234) returns [1,2,3,4,5]
  def split_to_array(number)
    number.to_s.chars.map(&:to_i)
  end
end
