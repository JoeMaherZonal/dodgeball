require_relative('team')

class Player
  attr_reader(:id, :name, :dob, :salary, :team_id)
  def initialize(options, runner)
    @id = options['id'].to_i
    @name = options['name']
    @dob = options['dob']
    @salary = options['salary'].to_i
    @team_id = options['team_id'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO players (name, dob, salary, team_id) VALUES ('#{ @name }', '#{ @dob }', '#{ @salary }', '#{ @team_id }' ) RETURNING *"
    return Player.map_items(sql, @runner).first
  end

  def team()
    sql = "SELECT * FROM teams WHERE id = #{@team_id}"
    return Team.map_items(sql, @runner).first
  end

  def stats()
    stats = {}
    stats['name'] = @name
    stats['dob'] = @dob
    stats['salary'] = @salary
    stats['team'] = team.name
    return stats
  end

  def update(info)
    @name = info['name'] if info['name']
    @dob = info['dob'] if info['dob']
    @salary = info['salary'] if info['salary']
    if info['new_team']
      team = Team.find_by_name(info['new_team'], @runner)
      @team_id = team.id if !team.nil? && team.team_exists?(team)
    end

    sql = "UPDATE players SET name = '#{@name}', dob = '#{@dob}', salary = #{@salary}, team_id = #{@team_id} WHERE id = #{@id} "
    @runner.run(sql)
  end

  def self.find_by_name(player_name, runner)
    sql = "SELECT * FROM players WHERE name LIKE '%#{player_name}%'"
    return Player.map_items(sql, runner).first
  end

  def self.all(runner)
    sql = "SELECT * FROM players"
    return Player.map_items(sql, runner)
  end

  def self.delete_all(runner)
    sql = "DELETE FROM players"
    runner.run(sql)
  end

  def self.map_items(sql, runner)
    players = runner.run(sql)
    result = players.map{|player| Player.new(player, runner)}
    return result
  end

end