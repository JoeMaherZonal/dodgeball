require('colorize')
class Viewer

  def menu_choices()
    while true
      system('clear')
      puts "UK DodgeBall League 2016 Analytics".blue
      puts ""
      puts "1 - Teams"
      puts "2 - Players and Coaches"
      puts "3 - Matches"
      puts "4 - Analytics"
      puts "5 - Exit"
      puts ""
      choice = get_input().to_i
      exit if choice == 5
      return choice if choice > 0 && choice < 5
    end
  end

  def teams_menu_choices()
    while true
      system('clear')
      puts "Teams menu".blue
      puts ""
      puts "1 - View all teams and statistcs"
      puts "2 - Add a new team"
      puts "3 - Update a current teams info"
      puts "4 - Return to Main menu"
      puts ""
      choice = get_input().to_i
      return choice if choice > 0 && choice < 5
    end
  end

  def print_teams_titles()
    puts "\tTeam names\tWins\t Losses\t    Draws\tPlayers"
    puts "\t-------------------------------------------------------"
  end

  def print_team_details(stats)
    puts "\t#{stats['name']}\t#{stats['wins']}\t #{stats['losses']} \t    #{stats['draws']} \t\t#{stats['players']}"
  end

  def display_team_editor(teams)
    clear()
    puts "<<< Team Editor >>>"
    puts ""
    puts "Current teams:"
    teams.each do |team|
      print "#{team.name}\t"
    end
    puts ""
    puts ""

    puts "Which team would like to update?"
    return get_input()
  end

  def p_c_menu_choices()
    while true
      system('clear')
      puts "Players and Coaches menu"
      puts ""
      puts "1 - View all players and statistcs"
      puts "2 - View all coaches and statistcs"
      puts "3 - Update a current players info"
      puts "4 - Update a current coaches info"
      puts "5 - Add a new player"
      puts "6 - Add a new coach"
      puts "7 - Return to Main menu"
      puts ""
      choice = get_input().to_i
      return choice if choice > 0 && choice < 8
    end
  end

  def print_players_title()
    puts ""
    puts "\tName\t\tDOB\t\tTeam\t\t  Salary".blue
    puts "\t--------------------------------------------------------"
  end

  def print_player_stats(stats)
    puts "\t#{stats['name']}\t#{stats['dob']}\t#{stats['team']}\t  £#{stats['salary']}"
  end

  def get_player_update_info(player_name)
    clear()
    puts "<< Update #{player_name} >>>".blue
    puts ""
    puts "New name:"
    new_name = get_input
    puts "New DOB:"
    new_dob = get_input()
    puts "New Salary"
    new_salary = get_input.to_i
    puts "New team"
    new_team = get_input

    new_info = {}
    new_info['name'] = new_name if new_name != ""
    new_info['dob'] = new_dob if new_dob != ""
    new_info['salary'] = new_salary if new_salary != ""
    new_info['new_team'] = new_team if new_team != ""
    return new_info
  end

  def get_new_player_info(type)
    options = {}
    clear()
    puts "<<< Add new #{type} >>>".blue
    puts ""
    puts "What is the #{type}s name?"
    name = get_input()
    puts "What is the #{type}s birthdate? [yyyy-dd-mm]"
    dob = get_input
    puts "What is this #{type}s salary?"
    salary = get_input.to_i
    options['name'] = name
    options['dob'] = dob
    options['salary'] = salary
    return options
  end

  def successfuly_updated_player(player_name)
    puts ""
    puts "Successfuly updated #{player_name}!".green
  end

  def display_player_editor(type)
    clear()
    puts "<<< #{type} editor >>>".blue
  end

  def display_players(type)
    puts ""
    puts "Which #{type} do you want to update?"
    return get_input()
  end

  def matches_menu_choices()
    while true
      system('clear')
      puts "Matches menu".blue
      puts ""
      puts "1 - View all Matches and statistcs"
      puts "2 - Add a new Match"
      puts "3 - Update a current match info"
      puts "4 - Return to Main menu"
      puts ""
      choice = get_input().to_i
      return choice if choice > 0 && choice < 5
    end
  end

  def find_match_search_criteria()
    clear()
    puts "<<< Update Match >>>".blue
    puts ""
    puts "Find the match ID number by searching for a team that played"
    return get_input()
  end

  def match_creator_title()
    clear()
    puts "<<< Match creator >>>".blue
    puts ""
  end

  def select_id()
    puts ""
    puts "Enter the ID of the match you want to update?"
    return get_input().to_i
  end

  def not_matching_results()
    puts "No matching results, try again. Or type exit to go back".red
    gets.chomp
  end

  def wrong_id()
    puts "You entered an invalid ID"
  end

  def results_title()
    puts ""
    puts "\tMatch ID\tAway Team    \tHome Team\tScore".blue
  end

  def get_team_name_ha(type)
    puts "Which team played at #{type}?"
    return get_input()
  end

  def successfuly_added_match()
    puts ""
    puts "Match was succesfuly added!".green
  end

  def print_match_titles()
    puts ""
    puts "\tHome Team\tScores\t     Away Team".blue
  end

  def get_score(name)
    puts "What was the score of #{name}?"
    return get_input().to_i
  end

  def could_not_find_team(team_name)
    puts "Could not find #{team_name}!".red
  end

  def get_input()
    print "> ".blue
    return gets.chomp
  end

  def get_team_name()
    puts ""
    puts "What is the name of the new team?"
    return get_input()
  end

  def successfuly_added_player(name)
    puts ""
    puts "Successfuly added #{name}!".green
    gets.chomp
  end

  def get_team_name_of_player(name)
    puts "What is the name of the team #{name} plays for?"
    return get_input()
  end

  def not_a_valid_team()
    puts "You did not enter a valid team, type 'list' to view team names".red
  end

  def successfuly_added(name)
    puts ""
    puts "#{name} was successfuly added to Teams".green
    sleep(1)
  end

  def failed_to_add(name)
    puts ""
    puts "Unable to add #{name} to Teams".red
    sleep(1)
  end

  def clear()
    system('clear')
  end

  def get_new_name(name)
    puts ""
    puts "What will the new name for #{name} be?"
    return get_input
  end

  def updated_team_successfuly(name)
    puts ""
    puts "#{name} was successfuly updated!".green
    sleep(1)
  end

  def did_not_update(name)
    puts ""
    puts "#{name} was not updated!".red
    sleep(1)
  end

end