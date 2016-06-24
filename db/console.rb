require( 'pry-byebug' )
require_relative( 'sql_runner' )
require_relative( '../player' )
require_relative( '../coach' )
require_relative( '../match' )
require_relative( '../team' )


runner = SqlRunner.new({dbname: 'dodgeball', host: 'localhost'})

Match.delete_all(runner)
Player.delete_all(runner)
Coach.delete_all(runner)
Team.delete_all(runner)

team1 = Team.new( {'name' => "Jammy Dodgers"}, runner).save
team2 = Team.new( {'name' => "Dirty Ducks"}, runner).save

player1 = Player.new( {'name' => "Joe Maher", 'dob' => "01-10-1988", 'salary' => 30000, 'team_id' => team1.id }, runner).save
player2 = Player.new( {'name' => "Charlie Maher", 'dob' => "01-10-1988", 'salary' => 34000, 'team_id' => team1.id }, runner).save
player3 = Player.new( {'name' => "Kelsey Maher", 'dob' => "01-10-1988", 'salary' => 28000, 'team_id' => team2.id }, runner).save
player4 = Player.new( {'name' => "Steve Maher", 'dob' => "01-10-1988", 'salary' => 32500, 'team_id' => team2.id }, runner).save

coach1 = Coach.new( {'name' => "Rachel Barry", 'dob' => "01-21-1990", 'salary' => 65000, 'team_id' => team1.id }, runner).save
coach2 = Coach.new( {'name' => "Luke Barry", 'dob' => "01-21-1990", 'salary' => 45000, 'team_id' => team2.id }, runner).save

match1 = Match.new( {'home_team_id' => team1.id, 'away_team_id' => team2.id, 'away_team_score' => 5, 'home_team_score' => 3}, runner).save


binding.pry
nil