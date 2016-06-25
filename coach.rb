require_relative('team')

class Coach
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
    sql = "INSERT INTO coachs (name, dob, salary, team_id) VALUES ('#{ @name }', '#{ @dob }', '#{ @salary }', '#{ @team_id }' ) RETURNING *"
    return Coach.map_items(sql, @runner).first
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

    sql = "UPDATE coachs SET name = '#{@name}', dob = '#{@dob}', salary = #{@salary}, team_id = #{@team_id} WHERE id = #{@id} "
    @runner.run(sql)
  end

  def self.find_by_name(coach_name, runner)
    sql = "SELECT * FROM coachs WHERE name LIKE '%#{coach_name}%'"
    return Coach.map_items(sql, runner).first
  end

  def self.all(runner)
    sql = "SELECT * FROM coachs"
    return Coach.map_items(sql, runner)
  end

  def self.delete_all(runner)
    sql = "DELETE FROM coachs"
    runner.run(sql)
  end

  def self.map_items(sql, runner)
    coachs = runner.run(sql)
    result = coachs.map{|coach| Coach.new(coach, runner)}
    return result
  end
end