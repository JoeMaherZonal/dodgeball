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
      puts "4 - Line ups"
      puts "5 - Points"
      puts "6 - Exit"
      puts ""
      choice = get_input().to_i
      exit if choice == 6
      return choice if choice > 0 && choice < 6
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
    puts "\tTeam names\t\tWins\t Losses\t    Draws\tPlayers".blue
  end

  def print_team_details(stats)
    puts "\t#{stats['name'][0..14]}\t\t#{stats['wins']}\t #{stats['losses']} \t    #{stats['draws']} \t\t#{stats['players']}"
  end

  def display_team_editor(teams)
    clear()
    puts "<<< Team Editor >>>".blue
    puts ""
    puts "Current teams:".blue
    counter = 0
    teams.each do |team|
      print "#{team.name[0..12]}\t\t"
      counter += 1
      if counter > 2
        puts "\n"
        counter = 0
      end
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
  end

  def print_player_stats(stats)
    puts "\t#{stats['name'][0..13]}\t#{stats['dob']}\t#{stats['team'][0..14]}\t  £#{stats['salary']}"
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
    new_salary = get_input
    puts "New team"
    new_team = get_input

    new_info = {}
    new_info['name'] = new_name if new_name != ""
    new_info['dob'] = new_dob if new_dob != ""
    new_info['salary'] = new_salary if new_salary != ""
    new_info['new_team'] = new_team if new_team != ""
    return new_info
  end

  def time_rand from = 0.0, to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  def get_new_player_info(type)
    options = {}
    clear()
    puts "<<< Add new #{type} >>>".blue
    puts ""
    puts "What is the #{type}s name?"
    name = get_input()
    puts "What is the #{type}s birthdate? [yyyy-mm-dd]"
    dob = get_input()
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

  def get_new_home_team()
    clear()
    puts "What team played at home?"
    return get_input()
  end

  def get_new_away_team()
    puts "What team played away?"
    return get_input()
  end

  def successfuly_updated_match()
    puts ""
    puts "Successfuly updated match!".green
  end

  def get_new_scores(info)
    puts "What did the away team score?"
    a_score = get_input()
    puts "What did the home team score?"
    h_score = get_input()
    info['away_team_score'] = a_score if a_score != ""
    info['home_team_score'] = h_score if h_score != ""
    return info
  end

  def clear()
    system('clear')
  end

  def get_new_name(name)
    puts ""
    puts "What will the new name for #{name} be?"
    return get_input()
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

  def get_team_name()
    puts "Find a team by typing part of their name:"
    return get_input()
  end

  def successfuly_added_point()
    puts "Successfuly saved point!".green
  end

  def select_match_by_id()
    puts "Enter the ID of the Match the point was won on:"
    return get_input().to_i
  end

  def no_such_match_id()
    puts "No such match exists!".red
    get_input
  end

  def teams_have_not_played(home, away)
    puts "#{home} have never played #{away}!".red
  end

  def point_creator()
    clear()
    data = {}
    puts "<<< Points Creator >>>".blue
    puts ""
    puts "We'll need to find the match, who played at home?"
    data['home_team'] = get_input()
    puts "Who played away?"
    data['away_team'] = get_input()
    puts "Who scored this point?"
    data['player'] = get_input
    return data
  end

  def matched_matches_title()
    puts "\tMatch ID\tHome Team\tAway Team\tScore".blue
  end

  def invalid_team(type, selection)
    puts "You entered an invalid #{type} team with #{selection}.".red
    gets.chomp
  end

  def invalid_player(selection)
    puts "Could not find a player with #{selection}."
  end

  def linups_get_info()
    info = {}
    count = 1
    clear()
    puts "<<< Lineup creator >>>".blue
    puts ""
    puts "We'll need six players in total"
    puts "Player #{count}:"
    info['player1'] = get_input()
    count += 1
    puts "Player #{count}:"
    info['player2'] = get_input()
    count += 1
    puts "Player #{count}:"
    info['player3'] = get_input()
    count += 1
    puts "Player #{count}:"
    info['player4'] = get_input()
    count += 1
    puts "Player #{count}:"
    info['player5'] = get_input()
    count += 1
    puts "Player #{count}:"
    info['player6'] = get_input()

    return info
  end

  def player_not_valid(invalid_player)
    puts ""
    puts "#{invalid_player} does not exist!".red
  end

end