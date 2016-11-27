#!/usr/bin/ruby

dictionary = []
File.open('words.txt').each do |line|
	line.strip!
	dictionary << line
end

keypad = {
	0 => [],
	1 => [],
	2 => ['a', 'b', 'c'],
	3 => ['d', 'e', 'f'],
	4 => ['g', 'h', 'i'],
	5 => ['j', 'k', 'l'],
	6 => ['m', 'n', 'o'],
	7 => ['p', 'r', 's'],
	8 => ['t', 'u', 'v'],
	9 => ['x', 'y', 'z']
 }

# Method to find words from a phone number
def phone_word(number, dictionary, keypad)

	# Declare empty storage array for final words
	final_words = []

	# While number length is not zero
	while number.length != 0
		# Hold the entire dictionary in temporary storage
		temp_storage = dictionary

		# Declare emtpy storage for possible matches
		candidates = []

		# Iterate through the number one digit at a time
		number.each_index do |digit_index|

			# Iterate through temporary storage one digit at a time
			temp_storage.each do |word|

				# If the word is longer than the number of letters we are checking, throw it out
				if word.length > number.length
					next

				# Otherwise, if the letter at this index matches an available letter value of the number at this index, store the word as a possible candidate. Or if we've gotten to the end of that word, simply store it as a final word.
				elsif keypad[number[digit_index]].include? word[digit_index]
					if word.length == (digit_index + 1) && !final_words.include?(word)
						final_words << word
					else
						candidates << word
						# puts "Index #{digit_index}, Number #{number[digit_index]}, Accepting #{word}"
					end
				end

			end # End of iterating through the words in temporary storage
			# puts"(((((((((((((())))))))))))))"
			# puts candidates

			# Reduce temp storage to just eligible candidates
			temp_storage = candidates

			# Reset candidates array
			candidates = []
		end # End of iterating through the number

		# Remove the first digit in the number and start over
		number.shift

	end # End of the while loop

	# having left the loop iterating through the number, return the final words
	return final_words.sort

end # End of the phone_word method

print "The number 2872253 contains the following word conversions: #{phone_word([2,8,7,2,2,5,3], dictionary, keypad)}"
