
class Point
  attr_reader(:id, :player_id, :match_id)
  def initialize(options, runner)
    @id = options['id']
    @player_id = options['player_id']
    @match_id = options['match_id']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO points (player_id, match_id) VALUES ('#{ @player_id }', '#{ @match_id }') RETURNING *"
    return Point.map_items(sql, @runner).first
  end

  def self.map_items(sql, runner)
    points = runner.run(sql)
    result = points.map{|point| Point.new(point, runner)}
    return result
  end

end