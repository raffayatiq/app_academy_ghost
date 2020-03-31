require_relative 'game.rb'
require_relative 'aiplayer.rb'
require_relative 'player.rb'

def play
	players = []
	puts "Choose number of Human Players: "
	number_of_human_players = gets.chomp.to_i
	names_of_human_players = []
	(number_of_human_players).times do |i|
		puts "Enter names of each player..." if i == 0
		print "Player #{i+1}: "
		names_of_human_players << gets.chomp
	end
	
	#Setting Human Players
	names_of_human_players.each do |name|
		players << Player.new(name)
	end
	
	puts "Choose number of AI Players: "
	number_of_AI_players = gets.chomp.to_i
	names_of_AI_players = []
	(number_of_AI_players).times do |i|
		puts "Enter names of each player..." if i == 0
		print "Player #{i+1}: "
		names_of_AI_players << gets.chomp
	end
	
	#Setting AI Players
	names_of_AI_players.each do |name|
		players << AiPlayer.new(name)
	end

	game = Game.new(*players)
	game.run
end

play