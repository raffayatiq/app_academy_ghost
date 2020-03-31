class Player
	attr_reader :name, :ghost

	def initialize(name)
		@name = name
		@ghost = ""
	end

	def guess
		puts "Player #{@name}'s turn. Make a guess..."
		gets.chomp
	end

	def alert_invalid_guess
		puts "Invalid guess. Try again..."
		self.guess
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
end