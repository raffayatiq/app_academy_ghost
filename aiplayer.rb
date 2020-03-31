require 'set'

class AiPlayer
	attr_reader :name, :ghost

	def initialize(name)
		@name = name
		@ghost = ""
		@number_of_other_players = nil
		@winning_moves = []
		@losing_moves = []
	end

	def lost
		case @ghost
		when ""
			@ghost += "G"
		when "G"
			@ghost += "H"
		when "GH"
			@ghost += "O"
		when "GHO"
			@ghost += "S"
		when "GHOS"
			@ghost += "T"
		end
	end

	def set_number_of_other_players(number)
		@number_of_other_players = number
	end

	def set_winning_moves(fragment, dictionary)
		alphabets = ("a".."z").to_a
		alphabets.each do |alphabet|
			possible_word = fragment + alphabet

			possible_words = dictionary.select { |word| word.start_with?(possible_word) }

			possible_words.each do |word|
				additional_letters_of_each_word = word.length - possible_word.length
				if additional_letters_of_each_word <= @number_of_other_players
					@winning_moves << alphabet
					break
				end
			end
		end
	end

	def set_losing_moves(fragment, dictionary)
		alphabets = ("a".."z").to_a
		alphabets.each do |alphabet|
			possible_word = fragment + alphabet

			possible_words = dictionary.select { |word| word.start_with?(possible_word) }

			possible_words.each do |word|
				word_to_set = Set.new([word])
				if word_to_set < dictionary
					@losing_moves << alphabet
					break
				end
			end
		end
	end

	def guess(fragment, dictionary)
		puts "Player #{@name}'s turn. Make a guess..."
		set_winning_moves(fragment, dictionary)
		set_losing_moves(fragment, dictionary)
		if @winning_moves.length == 0
			random_losing_move = rand(0...@losing_moves.length)
			return @losing_moves[random_losing_move]
		else
			random_winning_move = rand(0...@winning_moves.length)
			return @winning_moves[random_winning_move]
		end
	end
end
