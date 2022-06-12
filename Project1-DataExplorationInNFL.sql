--SQL Data Exploration Project

--Beginning Data Addition & Reformat
--Reformat Numbers from VarChar to INT

alter table PortfolioProject1..ScoreData alter column score_away int
alter table PortfolioProject1..ScoreData alter column score_home int
alter table PortfolioProject1..ScoreData alter column spread_favorite float

-- Add Team Abbreviations

alter table PortfolioProject1..ScoreData 
    add team_away_abb as (case [team_away] 
                        when 'Arizona Cardinals' then 'ARI'
                        when 'Phoenix Cardinals' then 'ARI'
                        when 'St. Louis Cardinals' then 'ARI'
                        when 'Atlanta Falcons' then 'ATL'
                        when 'Baltimore Ravens' then 'BAL'
                        when 'Buffalo Bills' then 'BUF'
                        when 'Carolina Panthers' then 'CAR'
                        when 'Chicago Bears' then 'CHI'
                        when 'Cincinnati Bengals' then 'CIN'
                        when 'Cleveland Browns' then 'CLE'
						when 'Dallas Cowboys' then 'DAL'
						when 'Denver Broncos' then 'DEN'
						when 'Detroit Lions' then 'DET'
						when 'Green Bay Packers' then 'GB'
						when 'Houston Texans' then 'HOU'
						when 'Baltimore Colts' then 'IND'
						when 'Indianapolis Colts' then 'IND'
						when 'Jacksonville Jaguars' then 'JAX'
						when 'Kansas City Chiefs' then 'KC'
						when 'Los Angeles Chargers' then 'LAC'
						when 'San Diego Chargers' then 'LAC'
						when 'Los Angeles Rams' then 'LAR'
						when 'St. Louis Rams' then 'LAR'
						when 'Miami Dolphins' then 'MIA'
						when 'Minnesota Vikings' then 'MIN'
						when 'New England Patriots' then 'NE'
						when 'Boston Patriots' then 'NE'
						when 'New Orleans Saints' then 'NO'
						when 'New York Giants' then 'NYG'
						when 'New York Jets' then 'NYJ'
						when 'Los Angeles Raiders' then 'LVR'
						when 'Oakland Raiders' then 'LVR'
						when 'Philadelphia Eagles' then 'PHI'
						when 'Pittsburgh Steelers' then 'PIT'
						when 'Seattle Seahawks' then 'SEA'
						when 'San Francisco 49ers' then 'SF'
						when 'Tampa Bay Buccaneers' then 'TB'
						when 'Houston Oilers' then 'TEN'
						when 'Tennessee Oilers' then 'TEN'
						when 'Tennessee Titans' then 'TEN'
						when 'Washington Redskins' then 'WAS'
						when 'Washington Football Team' then 'WAS'
                        else 'Invalid'
                     end);

alter table PortfolioProject1..ScoreData 
    add team_home_abb as (case [team_home] 
                        when 'Arizona Cardinals' then 'ARI'
                        when 'Phoenix Cardinals' then 'ARI'
                        when 'St. Louis Cardinals' then 'ARI'
                        when 'Atlanta Falcons' then 'ATL'
                        when 'Baltimore Ravens' then 'BAL'
                        when 'Buffalo Bills' then 'BUF'
                        when 'Carolina Panthers' then 'CAR'
                        when 'Chicago Bears' then 'CHI'
                        when 'Cincinnati Bengals' then 'CIN'
                        when 'Cleveland Browns' then 'CLE'
						when 'Dallas Cowboys' then 'DAL'
						when 'Denver Broncos' then 'DEN'
						when 'Detroit Lions' then 'DET'
						when 'Green Bay Packers' then 'GB'
						when 'Houston Texans' then 'HOU'
						when 'Baltimore Colts' then 'IND'
						when 'Indianapolis Colts' then 'IND'
						when 'Jacksonville Jaguars' then 'JAX'
						when 'Kansas City Chiefs' then 'KC'
						when 'Los Angeles Chargers' then 'LAC'
						when 'San Diego Chargers' then 'LAC'
						when 'Los Angeles Rams' then 'LAR'
						when 'St. Louis Rams' then 'LAR'
						when 'Miami Dolphins' then 'MIA'
						when 'Minnesota Vikings' then 'MIN'
						when 'New England Patriots' then 'NE'
						when 'Boston Patriots' then 'NE'
						when 'New Orleans Saints' then 'NO'
						when 'New York Giants' then 'NYG'
						when 'New York Jets' then 'NYJ'
						when 'Los Angeles Raiders' then 'LVR'
						when 'Oakland Raiders' then 'LVR'
						when 'Philadelphia Eagles' then 'PHI'
						when 'Pittsburgh Steelers' then 'PIT'
						when 'Seattle Seahawks' then 'SEA'
						when 'San Francisco 49ers' then 'SF'
						when 'Tampa Bay Buccaneers' then 'TB'
						when 'Houston Oilers' then 'TEN'
						when 'Tennessee Oilers' then 'TEN'
						when 'Tennessee Titans' then 'TEN'
						when 'Washington Redskins' then 'WAS'
						when 'Washington Football Team' then 'WAS'
                        else 'Invalid'
                     end);

--Query to Re-pull All Data for Reference
select * from PortfolioProject1..ScoreData

select * from PortfolioProject1..TeamData

--League-Wide Analysis

-- Year of Birth Season Results - Entire League 1999 Season
select * from PortfolioProject1..ScoreData
	where schedule_season = 1999 

--Super Bowl Winner & Score from 1999
select schedule_date, schedule_season, schedule_week, team_home, score_home, team_away, score_away, stadium, 
stadium_neutral, schedule_playoff from PortfolioProject1..ScoreData
	where schedule_season = 1999 and schedule_week = 'Superbowl'

--Highest Scoring Games in 1999
select team_away, score_away, team_home, score_home, (score_away + score_home) as TotalScore, schedule_season,
stadium, team_favorite_id from PortfolioProject1..ScoreData
	where schedule_season = 1999
	order by TotalScore desc

--Largest Margins of Victory in 1999
select team_away, score_away, team_home, score_home, team_favorite_id, (abs(spread_favorite)) as PointSpread, 
abs(score_away-score_home) as MarginOfVictory from PortfolioProject1..ScoreData
	where schedule_season = 1999
	order by MarginOfVictory desc

--Total Home Score vs Total Away Score ("Home Field Advantage")
select schedule_season, (TotalHomeScore-TotalAwayScore) as HomeFieldAdv from
	(select schedule_season, sum(score_home) as TotalHomeScore, sum(score_away) as TotalAwayScore
	from PortfolioProject1..ScoreData
		Group by schedule_season) as HomeFieldCalc
	Order by schedule_season desc

--Favorite Team Analysis (Philadelphia Eagles)

-- Eagles Super Bowl Appearances
select * from PortfolioProject1..ScoreData
	where (team_away = 'Philadelphia Eagles' or team_home = 'Philadelphia Eagles') and schedule_week = 'Superbowl'
	order by schedule_season desc

--Eagles All-Time Wins
select schedule_season, schedule_week, team_away, score_away, team_home, score_home, team_favorite_id from PortfolioProject1..ScoreData
	where (team_away = 'Philadelphia Eagles' and score_away > score_home)
	or (team_home = 'Philadelphia Eagles' and score_home > score_away)
	order by schedule_season desc

--Eagles Ties?
select schedule_season, schedule_week, team_away, score_away, team_home, score_home, team_favorite_id from PortfolioProject1..ScoreData
	where (team_away = 'Philadelphia Eagles' and score_away = score_home)
	or (team_home = 'Philadelphia Eagles' and score_home = score_away)
	order by schedule_season desc

--How Many Times Did the Eagles Cover the Spread in 2021?
select schedule_season, schedule_week, team_away, team_away_abb, score_away, team_home, team_home_abb, score_home, 
team_favorite_id, spread_favorite from PortfolioProject1..ScoreData
where schedule_season = 2021 and (
								(team_favorite_id ='PHI' and team_away_abb = 'PHI' and (score_away-score_home>abs(spread_favorite)))
								or (team_favorite_id ='PHI' and team_home_abb = 'PHI' and (score_home-score_away>abs(spread_favorite)))
								or (team_favorite_id <>'PHI' and team_away_abb = 'PHI' and (score_home-score_away<abs(spread_favorite)))
								or (team_favorite_id <>'PHI' and team_home_abb = 'PHI' and (score_away-score_home<abs(spread_favorite)))
								)