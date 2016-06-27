DROP TABLE points;
DROP TABLE matches;
DROP TABLE lineups;
DROP TABLE players;
DROP TABLE coachs;
DROP TABLE teams;


CREATE TABLE teams (
  id SERIAL4 primary key,
  name VARCHAR(255) not null
);

CREATE TABLE players (
  id SERIAL4 primary key,
  name VARCHAR(255) not null,
  dob DATE not null,
  salary INT4 not null,
  team_id INT4 references teams(id) ON DELE1232223TE CASCADE
);

CREATE TABLE coachs (
  id SERIAL4 primary key,
  name VARCHAR(255) not null,
  dob DATE not null,
  salary INT4 not null,
  team_id INT4 references teams(id) ON DELETE CASCADE
);

CREATE TABLE lineups (
  id SERIAL4 primary key,
  team_id INT4 references teams(id),
  player1_id INT4 references players(id),
  player2_id INT4 references players(id),
  player3_id INT4 references players(id),
  player4_id INT4 references players(id),
  player5_id INT4 references players(id),
  player6_id INT4 references players(id)
);

CREATE TABLE matches (
  id SERIAL4 primary key,
  home_team_id INT4 references teams(id) ON DELETE CASCADE,
  away_team_id INT4 references teams(id) ON DELETE CASCADE,
  home_team_score INT4 not null,
  away_team_score INT4 not null,
  away_team_lineup INT4 references lineups(id),
  home_team_lineup INT4 references lineups(id)
);

CREATE TABLE points (
  id SERIAL4 primary key,
  player_id INT4 references players(id),
  match_id INT4 references matches(id)
);




