
class CLI
  BASE_PATH = "https://www.allblacks.com"

  def call
    greeting
    player_maker
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
    else
      puts "Sorry didn't recognize that command. Please try again!"
      puts "\n"
      menu
    end

  end

  def player_menu
    puts "To inspect a player, type their name or number below. Type Menu to return to main menu"
    input2 = gets.strip.downcase
    #players_downcased = Player.all.map(&:downcase) for future improvements
    if input2 == "menu"
      menu
    elsif input2.downcase == "quit"
      goodbye
    
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
    if input.to_i > Player.all.size || input.to_i < 1
      puts "\n"
      puts "That's outside of the range of players! Please look at the list again."
      puts "\n"
      #players_displayer
      player_menu
    else
      Player.all.each.with_index do |player,index|
        if Player.all[index].name.downcase == input || index == input.to_i - 1 && Player.all[index].position == nil
          attributes = TeamScraper.scrape_player_page(BASE_PATH + Player.all[index].player_url)
          player.add_player_info(attributes)
        end
      end
    end
  end

  def players_displayer
    Player.all.each.with_index do |player, index|
      puts "#{index+1} #{Player.all[index].name}."
    end

  end

  def player_info_displayer(input_name)
    Player.all.each.with_index do |player, index|
      if Player.all[index].name.downcase == input_name || index == input_name.to_i-1
        puts "Name: #{player.name.upcase}."
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
