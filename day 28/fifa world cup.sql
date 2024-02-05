CREATE DATABASE fifa_WorldCup;

USE fifa_WorldCup;

select * from dbo.fifa_world_cup;

-- Easy Level:
-- 1-Retrieve all columns from the Matches table.
select * from dbo.fifa_world_cup;


-- 2-Display the teams, date, and category of matches.
select team1,team2,date,category from dbo.fifa_world_cup;


-- 3-Show the total attempts for both teams in each match.
select 
team1,
total_attempts_team1,
team2,
total_attempts_team2 
from dbo.fifa_world_cup;


-- 4-List the matches where the possession in contest is more than 60%.
SELECT team1,team2,category
FROM dbo.fifa_world_cup
WHERE CAST(SUBSTRING(possession_in_contest, 1, CHARINDEX('%', possession_in_contest) - 1) AS int) > 60;

select * from dbo.fifa_world_cup;

-- 5-Display the teams and the total number of goals they scored.
select team1,number_of_goals_team1,team2,number_of_goals_team2 from dbo.fifa_world_cup;


-- Intermediate Level:

-- 1-Find the matches where both teams had more than 10 attempts on target.
select * from dbo.fifa_world_cup
where on_target_attempts_team1= 10 and
on_target_attempts_team2 = 10;



-- 2-Show the teams and the total number of assists they recorded.
select team,sum(total_assists) as 'Number_of_assists' from 
(select team1 as team, sum(assists_team1) as total_assists from dbo.fifa_world_cup
group by team1
union  
select team2, sum(assists_team2) as total_assists from dbo.fifa_world_cup
group by team2) total_team
group by team
order by 2 desc;

-- 3-List the matches where the number of goals in the penalty area exceeded goals outside the penalty area.
SELECT team1, team2, category,
(CAST(goal_inside_the_penalty_area_team1 AS INT) + CAST(goal_inside_the_penalty_area_team2 AS INT)) as goal_inside_penalty_area ,
(CAST(goal_outside_the_penalty_area_team1 AS INT) + CAST(goal_outside_the_penalty_area_team2 AS INT)) as goal_outside_penalty_area
FROM dbo.fifa_world_cup
WHERE 
    (CAST(goal_inside_the_penalty_area_team1 AS INT) + CAST(goal_inside_the_penalty_area_team2 AS INT)) >
    (CAST(goal_outside_the_penalty_area_team1 AS INT) + CAST(goal_outside_the_penalty_area_team2 AS INT));


-- 4-Display the teams with the highest possession in a single match.
select team1,team2,category,
MAX(CAST(SUBSTRING(possession_in_contest, 1, CHARINDEX('%', possession_in_contest) - 1) AS int)) as possession
from dbo.fifa_world_cup
group by team1,team2,category
order by possession desc;

-- 5-Find the matches where both teams had fewer than 5 attempts on target.
select team1,team2,category from dbo.fifa_world_cup
where on_target_attempts_team1>5 and on_target_attempts_team2>5;


-- Advanced Level:

-- 1-Calculate the average possession for each team.
select team , sum(avg_possession) as avg_possession from 
(select team1 as team,
avg(CAST(SUBSTRING(possession_team1, 1, CHARINDEX('%', possession_team1) - 1) AS int)) as avg_possession
from dbo.fifa_world_cup
group by team1
union
select team2,
avg(CAST(SUBSTRING(possession_team2, 1, CHARINDEX('%', possession_team2) - 1) AS int)) as avg_possession
from dbo.fifa_world_cup
group by team2) possession
group by team
order by 2 desc;



-- 2-Show the matches where the number of on-target attempts is greater than off-target attempts for both teams.
select team1,team2,category from dbo.fifa_world_cup
where on_target_attempts_team1>off_target_attempts_team1
and on_target_attempts_team2>off_target_attempts_team2;


-- 3-Find the teams with the highest total offers to receive.
SELECT
    team,
    SUM(total_offers_to_receive) AS total_offers_to_receive
FROM (
    SELECT
        team1 AS team,
        SUM(CAST(total_offers_to_receive_team1 AS INT)) AS total_offers_to_receive
    FROM dbo.fifa_world_cup
    GROUP BY team1 
    UNION ALL
    SELECT
        team2 AS team,
        SUM(CAST(total_offers_to_receive_team2 AS INT)) AS total_offers_to_receive
    FROM dbo.fifa_world_cup
    GROUP BY team2
) AS total_offers
GROUP BY team
ORDER BY total_offers_to_receive DESC;


-- 4-Display the teams with the most completed line breaks in a single match.
select category,team1,team2,max(completed_line_breaksteam1),max(completed_line_breaks_team2) from dbo.fifa_world_cup
group by category, team1,team2;


-- 5-List the matches with the highest total number of fouls.
WITH MatchFouls AS (
    SELECT
        category,
        team1,
        team2,
        fouls_against_team1 AS fouls_team1,
        fouls_against_team2 AS fouls_team2
    FROM dbo.fifa_world_cup
)
SELECT
    category,
    team1,
    team2,
    fouls_team1 + fouls_team2 AS total_fouls
FROM MatchFouls
ORDER BY total_fouls DESC;


-- Expert Level:
-- 1-Identify the matches where both teams completed defensive line breaks.
select team1,completed_defensive_line_breaksteam1,
team2,completed_defensive_line_breaks_team2
from dbo.fifa_world_cup;

-- 2-Calculate the percentage of passes completed for each team.
WITH TeamPasses AS (
    SELECT
        category, team1 AS team,
        SUM(passes_completed_team1) AS passes_completed,
        SUM(passes_team1) AS total_passes
    FROM dbo.fifa_world_cup
    GROUP BY category, team1
    UNION ALL
   SELECT
        category, team2 AS team,
        SUM(passes_completed_team2) AS passes_completed,
        SUM(passes_team2) AS total_passes
    FROM dbo.fifa_world_cup
    GROUP BY category, team2
) 
SELECT
    category, team,
    (CAST(passes_completed AS FLOAT) / total_passes) * 100 AS pass_completion_percentage
FROM TeamPasses;




-- 3-Display the teams with the most crosses completed in a single match.
WITH TeamCrosses AS (
    SELECT
        category, team1 AS team,
        crosses_completed_team1 AS crosses_completed
    FROM dbo.fifa_world_cup
    UNION ALL
   SELECT
        category, team2 AS team,
        crosses_completed_team2 AS crosses_completed
    FROM dbo.fifa_world_cup
)

SELECT
    category, team,
    MAX(crosses_completed) AS max_crosses_completed
FROM TeamCrosses
GROUP BY category, team
ORDER BY max_crosses_completed DESC;

-- 4-Find the matches where the possession of both teams is within 5% of each other.
SELECT
    category,
    team1,
    team2,
    possession_team1,
    possession_team2
FROM dbo.fifa_world_cup
WHERE ABS(CAST(SUBSTRING(possession_team2, 1, CHARINDEX('%', possession_team2) - 1) AS int) - 
CAST(SUBSTRING(possession_team1, 1, CHARINDEX('%', possession_team1) - 1) AS int)) <= 5;


-- 5-Show the teams with the highest total number of forced turnovers.
WITH TeamForcedTurnovers AS (
    SELECT
        team1 AS team, forced_turnovers_team1 AS forced_turnovers
    FROM dbo.fifa_world_cup
UNION ALL
SELECT
        team2 AS team,
        forced_turnovers_team2 AS forced_turnovers
    FROM dbo.fifa_world_cup
)
SELECT
    team,
    SUM(forced_turnovers) AS total_forced_turnovers
FROM TeamForcedTurnovers
GROUP BY team
ORDER BY total_forced_turnovers DESC;



-- Master Level:
-- 1-Calculate the average number of goals conceded per match for each team.
WITH TeamConcededGoals AS (
    SELECT
        team1 AS team,
        conceded_team1 AS conceded_goals
    FROM
        dbo.fifa_world_cup

    UNION ALL

    SELECT
        team2 AS team,
        conceded_team2 AS conceded_goals
    FROM dbo.fifa_world_cup
)

SELECT
    team,
    AVG(conceded_goals) AS average_goals_conceded
FROM TeamConcededGoals
GROUP BY team;


-- 2-Display the teams with the highest total receptions between midfield and defensive lines.
WITH TeamReceptions AS (
    SELECT
        team1 AS team,
        receptions_between_midfield_and_defensive_lines_team1 AS receptions
    FROM dbo.fifa_world_cup 
    UNION ALL
    SELECT
        team2 AS team,
        receptions_between_midfield_and_defensive_lines_team2 AS receptions
    FROM dbo.fifa_world_cup
)
SELECT
    team,
    SUM(receptions) AS total_receptions
FROM
    TeamReceptions
GROUP BY team
ORDER BY total_receptions DESC;



-- 3-Identify the matches where both teams received more than 20 offers to receive.
select category from fifa_world_cup
where total_offers_to_receive_team1>20 and total_offers_to_receive_team2>20;

-- 4-Find the teams with the highest total defensive pressures applied.
select team, sum(defensive_pressures_applied) as defensive_pressures_applied
from (select team1 as team ,
defensive_pressures_applied_team1 as defensive_pressures_applied
from dbo.fifa_world_cup
union all
select team2,defensive_pressures_applied_team2 from dbo.fifa_world_cup) as defensive_pressure
group by team
order by 2 desc;

-- 5-Calculate the win percentage for each team.
SELECT
    team,
    SUM(total_wins) as total_wins,
    SUM(total_matches) as total_matches,
    round(SUM(total_wins) * 100.0 / NULLIF(SUM(total_matches), 0),2) as win_percentage
FROM (
    SELECT
        team1 as team,
        COUNT(CASE WHEN number_of_goals_team1 > number_of_goals_team2 THEN 1 END) as total_wins,
        COUNT(*) AS total_matches
    FROM dbo.fifa_world_cup
    GROUP BY team1
    UNION ALL
    SELECT
        team2 as team,
        COUNT(CASE WHEN number_of_goals_team2 > number_of_goals_team1 THEN 1 END) as total_wins,
        COUNT(*) AS total_matches
    FROM dbo.fifa_world_cup
    GROUP BY team2
) as teams
GROUP BY team
order by win_percentage desc;




-- Challenge Level:
-- 1-Identify the matches with the highest total attempts outside the penalty area.
select category,sum(attempts_outside_the_penalty_area_team1+attempts_outside_the_penalty_area_team2) 
as total_attempts_outside_penalty_area
from dbo.fifa_world_cup
group by category
order by total_attempts_outside_penalty_area desc;


