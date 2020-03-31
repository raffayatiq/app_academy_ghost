require_relative 'player.rb'
require_relative 'aiplayer.rb'
require 'set'

class Game
	attr_reader :current_player, :previous_player, :fragment

	def initialize(*players)
		@players = players
		@fragment = ""
		@current_player = @players[0]
		@previous_player = nil
		
		file = File.open("dictionary.txt")
		file_data = file.readlines.map(&:chomp)
		file_data_array_to_set = file_data.to_set
		@dictionary = file_data_array_to_set

		@losses = {}
		@players.each do |player|
			@losses[player] = player.ghost
		end

		@players.each do |player|
			if player.is_a?(AiPlayer)
				player.set_number_of_other_players(@players.length - 1)
			end
		end
	end

	def next_player!
		@previous_player = @players[0]
		@players.rotate!
		@current_player = @players[0]
	end

	def take_turn(player)
		player.is_a?(AiPlayer) ? guess = player.guess(@fragment, @dictionary) : guess = player.guess
		while !valid_play?(guess)
			puts "Invalid guess/No word possible. Guess again..."
			guess = player.guess
		end
		@fragment += guess
	end

	def valid_play?(string)
		alphabet = ("a".."z").to_a
		return false if !alphabet.include?(string)
		
		possible_word = @fragment + string
		@dictionary.each do |word|
			return true if word.include?(possible_word)
		end
		
		return false
	end

	def check_loss
		fragment_to_set = Set.new([@fragment])
		if fragment_to_set < @dictionary
			@previous_player.lost
			puts "Player #{@previous_player.name} lost!"
			puts "The word is #{@fragment}!"
			@fragment = ""
			self.display_standings
		end
	end

	def play_round
		self.take_turn(@current_player)
		self.next_player!
		self.check_loss
		self.update_losses
	end

	def update_losses
		@players.each do |player|
			@losses[player] = player.ghost
		end
	end

	def display_standings
		puts "CURRENT STANDINGS"
		print "PLAYERS".ljust(20)
		puts "GHOST STRING"
		@players.each do |player, player_ghost|
			print player.name.ljust(20)
			puts player.ghost
		end
	end

	def run
		while @players.length != 1
			print "FRAGMENT: "
			puts self.fragment
			self.play_round
			self.player_loss if @losses.has_value?("GHOST")
		end
		puts "Player #{@players[0].name} wins!"
	end

	def remove_player(player)
		@losses.delete(player)
		index_of_player = @players.index(player)
		@players.delete_at(index_of_player)
	end

	def player_loss
		loser = @losses.key("GHOST")
		puts "Player #{loser.name} has lost the game!"
		puts "Bye-bye Player #{loser.name}!"
		self.remove_player(loser)
		self.display_standings
	end
end