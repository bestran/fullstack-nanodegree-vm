-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;

\c tournament;

CREATE TABLE players (
	player_id serial PRIMARY KEY,
	player_name varchar(100)
);

CREATE TABLE matches (
	match_id serial PRIMARY KEY,
	winner int references players(player_id),
	loser int references players(player_id)
);

CREATE VIEW wins AS SELECT winner AS player_id, count(*) AS wins FROM matches GROUP BY winner;
CREATE VIEW losses AS SELECT loser AS player_id, count(*) AS losses FROM matches GROUP BY loser;
CREATE VIEW rankings AS SELECT p.player_id, p.player_name, COALESCE(w.wins,0) as wins, COALESCE(l.losses,0) as losses, COALESCE(w.wins,0)+COALESCE(l.losses,0) as played FROM players AS p LEFT JOIN wins AS w ON p.player_id = w.player_id LEFT JOIN losses AS l ON p.player_id = l.player_id;

