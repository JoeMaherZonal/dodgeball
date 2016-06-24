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

  def self.map_items(sql, runner)
    players = runner.run(sql)
    result = players.map{|player| Player.new(player, runner)}
    return result
  end



end