DROP TABLE matches;
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
  team_id INT4 references teams(id) ON DELETE CASCADE
);

CREATE TABLE coachs (
  id SERIAL4 primary key,
  name VARCHAR(255) not null,
  dob DATE not null,
  salary INT4 not null,
  team_id INT4 references teams(id) ON DELETE CASCADE
);

CREATE TABLE matches (
  id SERIAL4 primary key,
  home_team_id INT4 references teams(id) ON DELETE CASCADE,
  away_team_id INT4 references teams(id) ON DELETE CASCADE,
  home_team_score INT4 not null,
  away_team_score INT4 not null
);


