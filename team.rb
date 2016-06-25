require_relative('player')
require_relative('match')

class Team
  attr_reader(:id, :name)
  def initialize(options, runner)
    @id = options['id'].to_i
    @name = options['name']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO teams (name) VALUES ('#{ @name }') RETURNING *"
    return Team.map_items(sql, @runner).first
  end

  def team_exists?(team)
    sql = "SELECT * FROM teams WHERE name = '#{team.name}'"
    team = Team.map_items(sql, @runner)
    return team.length > 0
  end

  def players()
    sql = "SELECT * FROM players WHERE team_id = #{@id}"
    return Player.map_items(sql, @runner)
  end

  def matches()
    sql = "SELECT * FROM matches WHERE away_team_id = #{@id} OR home_team_id = #{@id}"
    return Match.map_items(sql, @runner)
  end

  def update(options)
    @name = options['name'] if (options['name'])
    sql = "UPDATE teams SET name = '#{@name}' WHERE id = #{id}"
    @runner.run(sql)
  end

  def stats()
    sql = "SELECT matches.* FROM matches
    INNER JOIN teams ON matches.away_team_id = teams.id OR matches.home_team_id = teams.id
    WHERE teams.id = #{@id}"
    valid_matches = Match.map_items(sql, @runner)
    stats = {}
    stats['wins'] = calc_wins(valid_matches)
    stats['losses'] = calc_losses(valid_matches)
    stats['draws'] = calc_draws(valid_matches)
    stats['name'] = @name
    stats['players'] = players.length
    return stats
  end

  def calc_wins(valid_matches)
    total = 0
    valid_matches.each do |match|
      total += 1 if (match.away_team_id == @id) && (match.away_team_score > match.home_team_score)
      total += 1 if (match.home_team_id == @id) && (match.home_team_score > match.away_team_score)
    end
    return total
  end

  def calc_losses(valid_matches)
    total = 0
    valid_matches.each do |match|
      total += 1 if (match.away_team_id == @id) && (match.away_team_score < match.home_team_score)
      total += 1 if (match.home_team_id == @id) && (match.home_team_score < match.away_team_score)
    end
    return total
  end

  def calc_draws(valid_matches)
    total = 0
    valid_matches.each do |match|
      total += 1 if (match.away_team_id == @id) && (match.away_team_score == match.home_team_score)
      total += 1 if (match.home_team_id == @id) && (match.home_team_score == match.away_team_score)
    end
    return total
  end


  def self.find_team_like(search_crit, runner)
    sql = "SELECT * FROM teams WHERE name LIKE '%#{search_crit}%' "
    team = Team.map_items(sql, runner).first
    return if team.nil?
    return team
  end
  
  def self.find_by_name(team_name, runner)
    sql = "SELECT * FROM teams WHERE name LIKE '%#{team_name}%'"
   team = Team.map_items(sql, runner).first
   return if team.nil?
   return team
  end

  def self.all(runner)
    sql = "SELECT * FROM teams"
    return Team.map_items(sql, runner)
  end

  def self.delete_all(runner)
    sql = "DELETE FROM teams"
    runner.run(sql)
  end

  def self.map_items(sql, runner)
    teams = runner.run(sql)
    result = teams.map{|team| Team.new(team, runner)}
    return result
  end

end