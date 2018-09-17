require 'pry'
require 'nokogiri'
require 'open-uri'
require_relative "../lib/all_blacks_players.rb"
require_relative "../lib/all_blacks_scraper.rb"


class CLI
  BASE_PATH = "https://www.allblacks.com"
def call
  greeting
  menu
end

def greeting
puts "Hello User! Welcome to the All Blacks Roster CLI."
puts "\n"
end

def menu
  puts "Main Menu, type an option to proceed:"
  puts "\n"
  puts "List: to view All Blacks roster"
  puts "Help: to get more info about this app"
  puts "Quit: to leave the app"
  puts "\n"

  input = gets.strip.downcase

  if input == "list"
    #TeamScraper.scrape_team_table
    #Player.all
    player_maker
    players_displayer
    player_menu
  elsif input == "help"
    puts "This app lists the current roster for the New Zealand international rugby team: the All Blacks."
    puts "Type list or List to receive the roster. Feel free to type in the name of a player after getting the list."
    puts "Go All Blacks!"
    puts "\n"
    menu
  elsif input == "quit"
    goodbye
  end

end

def player_menu
  puts "To inspect a player, type their name or number below. Type Menu to return to main menu"
  input2 = gets.strip.downcase
  if input2 == "menu"
    menu
  else
    player_attributer(input2)
    player_info_displayer(input2)
    menu
  end
end

def goodbye
  puts "Later!"
  sleep(2)
  exit
end

def player_maker
  player_array = TeamScraper.scrape_team_table
  Player.create_player_from_collection(player_array)
end

def player_attributer(input)
  Player.all.each.with_index do |player,index|
  if Player.all[index].name.downcase == input || index == input
    attributes = TeamScraper.scrape_player_page(BASE_PATH + Player.all[index].player_url)
    player.add_player_info(attributes)
  else
    "He's not on the squad!"
  end
  end

end

def players_displayer
  Player.all.each.with_index do |player, index|
    puts "#{index} #{Player.all[index].name}."
  end
end

def player_info_displayer(input_name)
  Player.all.each.with_index do |player, index|
    if Player.all[index].name.downcase == input_name || index == input_name
      puts "Name: #{input_name}."
      puts "Position: #{player.position}."
      puts "Hieght and Weight: #{player.physical}."
      puts "First test match: #{player.test_debut}."
      puts "Total points scored: #{player.points_scored}."
      puts "Number of games played: #{player.caps}."
      puts "Birthday #{player.birthday}."
      puts "\n"
    end
  end
end
end
