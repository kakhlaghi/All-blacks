#all_blacks_players

class Player
	#things i'm looking at for each player
	attr_accessor :name, :player_url, :position, :test_debut, :point_breakdown, :physical, :caps, :points_scored, :birthday

	@@all = []
	#taking in the hash scraped from the page containing the information. creating the object for each.
	def initialize(player_hash)
		player_hash.each do |attribute,value|
			self.send("#{attribute}=", value)
		end
		@@all << self
	end

	def self.all
		@@all
	end

	def self.create_player_from_collection(player_array)
		player_array.each do |player_hash| Player.new(player_hash) end
			#takes the array of hashes and creates a new player out of hash
			#see initialize
	end
	def add_player_info(info_hash)
		info_hash.each do |attr, value|
			self.send("#{attr}=", value)
		end
	end
	

end
