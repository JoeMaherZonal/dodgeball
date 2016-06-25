require_relative('team')

class Match
  attr_reader(:id, :away_team_id, :home_team_id, :away_team_score, :home_team_score)

  def initialize(options, runner)
    @id = options['id'].to_i
    @away_team_id = options['away_team_id'].to_i
    @home_team_id = options['home_team_id'].to_i
    @home_team_score = options['home_team_score'].to_i
    @away_team_score = options['away_team_score'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO matches (away_team_id, home_team_id, home_team_score, away_team_score) VALUES ('#{ @away_team_id }', '#{ @home_team_id }', '#{ @home_team_score }', '#{ @away_team_score }' ) RETURNING *"
    return Match.map_items(sql, @runner).first
  end

  def teams()
    sql = "SELECT * FROM teams WHERE id =  #{@away_team_id} OR id = #{home_team_id}"
    return Team.map_items(sql, @runner)
  end

  def away_team()
    sql = "SELECT * FROM teams WHERE id =  #{@away_team_id}"
    return Team.map_items(sql, @runner).first
  end

  def home_team()
    sql = "SELECT * FROM teams WHERE id = #{home_team_id}"
    return Team.map_items(sql, @runner).first
  end

  def self.search_by_team(search_crit, runner)
    sql = "SELECT matches.* FROM matches
    INNER JOIN teams ON teams.id = matches.away_team_id OR teams.id = matches.home_team_id
    WHERE teams.name LIKE '%#{search_crit}%'"
    return Match.map_items(sql, runner)
  end

  def self.return_match_by_id(match_id)
    sql "SELECT * FROM matches WHERE id = #{match_id}"
    return Match.map_items(sql, runner).first
  end


  def self.all(runner)
    sql = "SELECT * FROM matches"
    return Match.map_items(sql, runner)
  end

  def self.delete_all(runner)
    sql = "DELETE FROM matches"
    runner.run(sql)
  end

  def self.map_items(sql, runner)
    matches = runner.run(sql)
    result = matches.map{|match| Match.new(match, runner)}
    return result
  end


end