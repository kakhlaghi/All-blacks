#all_blacks_scraper
require 'open-uri'
require 'pry'

class TeamScraper
team3 = "worked"
#scrapes the all blacks team roster table at the bottom of the page.
def self.scrape_team_table
	#team_page = Nokogiri::HTML(open(team_url))
	team_page = Nokogiri::HTML(open("http://www.allblacks.com/teams/"))
	players = []
	#team = team_page.search("table.tile__team_details_squad").text.split(/(?<=[a-z])(?=[A-Z]))
	team_page.css("table.tile__team_details_squad tbody tr li.tile_item a").each do |player|
		player_url = player["href"]
		player_name = player.text
		#player_url2 = "#{player.attr("href")}"
		players << {:name => player_name, :player_url => player_url}
	end
	players
end

#scrapes the player pages for desired info
def self.scrape_player_page(player_url)
	tag = []
	detail = []
	i = 0
	player = {} #create hash for the players info
	player_page = Nokogiri::HTML(open(player_url))
	player_table = player_page.css("table tbody").text.split(/\s{2,}/)
	player_table.shift
	player_table.each.with_index do |item, index|
		index.even? ? tag << item : detail << item
	end
	tag.each.with_index do |item, index|
		case index
		when 0
			player[:position] = "#{detail[0]}"
		when 1
			player[:birthday] = "#{detail[1]}"
		when 2
			player[:physical] = "#{detail[2]}"
		when 3
			player[:test_debut] = "#{detail[3]}"
		when 4
			player[:point_breakdown] = "#{detail[4]}"
		when 5
			player[:points_scored] = "#{detail[5]}"
		when 6
			player[:caps] = "#{detail[6]}"
		end
		end
	player
end

end
