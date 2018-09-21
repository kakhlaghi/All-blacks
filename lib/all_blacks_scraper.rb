#all_blacks_scraper

class TeamScraper
  
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
		  if tag[index].include?("Position")
			  player[:position] = "#{detail[index]}"
		  elsif tag[index].include?("Born")
			  player[:birthday] = "#{detail[index]}"
		  elsif tag[index].include?("Physical")
			  player[:physical] = "#{detail[index]}"
	  	elsif tag[index].include?("Test Debut")
		  	player[:test_debut] = "#{detail[index]}"
		  elsif tag[index] == "Test Points Breakdown:"
			  player[:point_breakdown] = "#{detail[index]}"
		  elsif tag[index] == "Test Points:"
			  player[:points_scored] = "#{detail[index]}"
		  elsif tag[index] == "Caps:"
			  player[:caps] = "#{detail[index]}"
		  end
		end
	  player
  end


end
