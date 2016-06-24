class Match
  def initialize(options, runner)
    @id = options['id'].to_i
    @away_team_id = options['away_team_id'].to_i
    @home_team_id = options['home_team_id'].to_i
    @home_team_score = options['home_team_score'].to_i
    @away_team_score = options['away_team_score'].to_i
  end

  def save()
    sql = "INSERT INTO players (name, dob, salary, team_id) VALUES ('#{ @name }', '#{ @dob }', '#{ @salary }', '#{ @team_id }' ) RETURNING *"
    return Player.map_items(sql, @runner).first
  end

  def self.map_items(sql, runner)
    players = runner.run(sql)
    result = players.map{|player| Player.new(player, runner)}
    return result
  end

  
end