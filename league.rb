require_relative('coach')
require_relative('match')
require_relative('player')
require_relative('team')
require_relative('viewer')

class League
  attr_reader(:players, :coaches, :teams, :matches)
  def initialize(runner, viewer)
    @players = Player.all(runner)
    @coaches = Coach.all(runner)
    @teams = Team.all(runner)
    @matches = Match.all(runner)
    @runner = runner
    @viewer = viewer
  end

  def populate()
    @players = Player.all(runner)
    @coaches = Coach.all(runner)
    @teams = Team.all(runner)
    @matches = Match.all(runner)
  end

  def run()
    while true
      choice = @viewer.menu_choices()

      case choice
        when 1
          teams()
        when 2
          players_and_coaches()
        when 3
          matches()
        when 4
          analytics()
      end

    end
  end

  def players_and_coaches()
    while true
      choice = @viewer.p_c_menu_choices()
      case choice
        when 1
          view_players()
        when 2
          view_coaches()
        when 3
          update_player()
        when 4
          update_coach()
        when 5
          add_player()
        when 6
          add_coach()
        when 7
          return
      end
    end
  end

  def add_coach()
    options = @viewer.get_new_player_info('coach')

    while true
    team_name = @viewer.get_team_name_of_player(options['name'])
    teams = Team.all(@runner)
    teams.each {|team| puts team.name} if team_name == "list"
    team = Team.find_by_name(team_name, @runner)
      if !team.nil?
        options['team_id'] = team.id
        coach = Coach.new(options, @runner)
        coach.save()
        @viewer.successfuly_added_player(coach.name)
        return
      else
        @viewer.not_a_valid_team() if team_name != "list"
      end
    end
  end

  def add_player()
    options = @viewer.get_new_player_info('player')

    while true
    team_name = @viewer.get_team_name_of_player(options['name'])
    teams = Team.all(@runner)
    teams.each {|team| puts team.name} if team_name == "list"
    team = Team.find_by_name(team_name, @runner)
      if !team.nil?
        options['team_id'] = team.id
        player = Player.new(options, @runner)
        player.save()
        @viewer.successfuly_added_player(player.name)
        return
      else
        @viewer.not_a_valid_team() if team_name != "list"
      end
    end
  end

  def update_coach()
    @viewer.display_player_editor('coach')
    coachs = Coach.all(@runner)
    while true
      coach_name = @viewer.display_players('coach')
      if coach_name == "list"
        coachs.each {|coach| puts coach.name}
      else
        selected_coach = Coach.find_by_name(coach_name, @runner)
        return if selected_coach.nil?
        info = @viewer.get_player_update_info(selected_coach.name)
        selected_coach.update(info)
        @viewer.successfuly_updated_player(selected_coach.name)
        gets.chomp
        return
      end
    end
  end

  def update_player()
    @viewer.display_player_editor('player')
    players = Player.all(@runner)
    while true
      player_name = @viewer.display_players('player')
      if player_name == "list"
        players.each {|player| puts player.name}
      else
        selected_player = Player.find_by_name(player_name, @runner)
        return if selected_player.nil?
        info = @viewer.get_player_update_info(selected_player.name)
        selected_player.update(info)
        @viewer.successfuly_updated_player(selected_player.name)
        gets.chomp
        return
      end
    end
  end

  def view_coaches()
    @viewer.print_players_title()
    coaches = Coach.all(@runner)
    coaches.each do |coach|
      stats = coach.stats()
      @viewer.print_player_stats(stats)
    end
    gets.chomp
  end

  def view_players()
    @viewer.print_players_title()
    players = Player.all(@runner)
    players.each do |player|
      stats = player.stats()
      @viewer.print_player_stats(stats)
    end
    gets.chomp
  end

  def teams()
    while true
      choice = @viewer.teams_menu_choices()
      case choice
        when 1
          view_teams()
        when 2
           add_team()
        when 3
          update_teams()
        when 4
          return
      end
    end
  end

  def view_teams()
    @viewer.print_teams_titles()
    teams = Team.all(@runner)
    teams.each do |team|
      stats = team.stats()
      @viewer.print_team_details(stats)
    end
    gets.chomp
  end

  def update_teams()
    teams = Team.all(@runner)
    team_name = @viewer.display_team_editor(teams)
    team = Team.find_by_name(team_name, @runner)
    return if team.nil?
    new_name = @viewer.get_new_name(team.name)

    if new_name != ""
      team.update({'name' => new_name}) 
      @viewer.updated_team_successfuly(new_name)
    else
      @viewer.did_not_update(team.name)
    end
    gets.chomp
  end

  def add_team()
    team_name = @viewer.get_team_name()
    return if team_name == ""
    new_team = Team.new( {'name' => team_name}, @runner)
    new_team.save()
    if new_team.team_exists?(new_team)
      @viewer.successfuly_added(new_team.name)
    else
      @viewer.failed_to_add(new_team.name)
    end
    gets.chomp
  end

  def matches()
    while true
    choice = @viewer.matches_menu_choices()
      case choice
        when 1
          view_matches()
        when 2
          add_new_match()
        when 3
          update_match()
        when 4
          return
      end
    end
  end

  def update_match()
    id = find_id()
  end

  def find_id()
    while true
    search_crit = @viewer.find_match_search_criteria()
    return if  search_crit.downcase == 'exit'
    matches = Match.search_by_team(search_crit, @runner)
    @viewer.not_matching_results() if matches.length == 0
    @viewer.results_title() if matches.length > 0
    matches.each do |match|
      puts "\t#{match.id}\t\t#{match.home_team().name}\t#{match.away_team().name}\t#{match.away_team_score}:#{match.home_team_score}"
      end
      break if matches.length > 0
    end

    while true
    id = @viewer.select_id()
    selected_match = Match.return_match_by_id(id)
      if selected_match.nil?
        @viewer.wrong_id()
      else
        return selected_match
      end
    end
  end

  def add_new_match()
    @viewer.match_creator_title()
    home_team = get_team('home')
    home_score = @viewer.get_score(home_team.name)
    away_team = get_team('away')
    away_score = @viewer.get_score(away_team.name)
    match = Match.new( {'home_team_id' => home_team.id, 'away_team_id' => away_team.id, 'away_team_score' => away_score, 'home_team_score' => home_score}, @runner)
    match.save()
    @viewer.successfuly_added_match()
  end

  def get_team(type)
    while true
      team_name = @viewer.get_team_name_ha(type)
      team = Team.find_by_name(team_name, @runner)
      @viewer.could_not_find_team(team_name) if team.nil?
      return team if !team.nil?
    end
  end

  def view_matches()
    @viewer.print_match_titles()
    matches = Match.all(@runner)

    matches.each do |match|
      puts "\t#{match.home_team().name}\t#{match.home_team_score} : #{match.away_team_score}\t     #{match.away_team().name}"
    end
    gets.chomp
  end

  def add_matches()
  end

  def update_matches()
  end

  def analytics()
  end


end