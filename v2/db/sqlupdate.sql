ALTER TABLE matches ADD COLUMN away_team_lineup INT4 references lineups(id);
ALTER TABLE matches ADD COLUMN home_team_lineup INT4 references lineups(id);