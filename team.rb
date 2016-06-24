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

  def self.map_items(sql, runner)
    teams = runner.run(sql)
    result = teams.map{|team| Team.new(team, runner)}
    return result
  end
end