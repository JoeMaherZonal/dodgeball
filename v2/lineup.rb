require('player')

class Lineup
  def initialize(options, runner)
    @id = options['id'].to_i
    @team_id = options['team_id'].to_i
    @player1_id = options['player1_id'].to_i
    @player2_id = options['player2_id'].to_i
    @player3_id = options['player3_id'].to_i
    @player4_id = options['player4_id'].to_i
    @player5_id = options['player5_id'].to_i
    @player6_id = options['player6_id'].to_i
  end

  def save()
    sql = "INSERT INTO lineups (team_id, player1_id, player2_id, player3_id, player4_id, player5_id, player6_id) VALUES (#{ @team_id }, #{ @player1_id }, #{ @player2_id }, #{ @player3_id }, #{ @player4_id }, #{ @player5_id }, #{ @player6_id }) RETURNING *"
    return Lineup.map_items(sql, @runner).first
  end

  def players()
    sql = "SELECT * FROM players WHERE id = #{@player1_id} 
    OR id = #{@player2_id}
    OR id = #{@player3_id}
    OR id = #{@player4_id}
    OR id = #{@player5_id}
    OR id = #{@player6_id}"
    return Player.map_items(sql, @runner)
  end

  def team()
    sql = "SELECT * FROM teams WHERE id = #{@team_id}"
  end

  def self.all(runner)
    sql = "SELECT * FROM lineups"
    return Lineup.map_items(sql, runner)
  end

  def self.map_items(sql, runner)
    lineups = runner.run(sql)
    result = lineups.map{|lineup| Lineup.new(lineup, runner)}
    return result
  end

end