select * from ipl;


-- Retrieve all the columns from the 'IPL' table.
select * from ipl;

-- Display the unique home teams participating in the IPL.
select distinct(home_team) from ipl;

-- Find the total number of matches played in each season.
select season,count(*) as 'Number of Matches Played' from ipl 
group by season;

-- List the names of all the players who have won the Player of the Match award.
select distinct(pom) as 'player of the match' from ipl;

-- Display the venues where more than 10 matches have been played.
select venue_name,count(*) as 'Number of Matches Held' from ipl
group by venue_name
having count(*)>10
order by 2 desc;


-- Calculate the average score of the first innings for each season.
select
    season,
    avg(cast(
        case 
        when CHARINDEX('/', _1st_inning_score) > 0 
        then SUBSTRING(_1st_inning_score, 1, CHARINDEX('/', _1st_inning_score) - 1) 
        else _1st_inning_score 
        end 
    as int)) as 'Average Score of 1st innings'
from ipl
group by season
order by 1;


-- List the matches where the toss-winning team chose to field.
select season,
name, short_name, toss_won, decision, winner,
result
from ipl
where decision='BOWL FIRST';


-- Show the matches where the first inning score is greater than the second inning score.

select * from ipl 
where home_runs>away_runs;

-- Find the total number of boundaries (fours and sixes) scored by each team.

select 
    team,
	sum(total_boundaries) as total_boundaries
from (select  
        home_team as team,
        sum(home_boundaries) as total_boundaries
		from  ipl
    group by home_team   
    union all    
select 
away_team as team,
sum(away_boundaries)
    from ipl
group by away_team
) AS boundaries
group by team;


-- Display the venues along with the number of matches played, sorted by the number of matches in descending order.
select venue_name,count(*) as 'Total Matches Played' from ipl
group by venue_name
order by 2 desc;



-- Identify the matches where the result was a tie.
select * from ipl
where result like '%Match tied%';



-- Determine the team with the highest total score in IPL history.

with team_score as(
				select team,sum(score) as score,
				dense_rank() over(order by sum(score) desc) as rnk from(
					select home_team as team,
					sum(home_runs) as score 
							from ipl
					group by home_team 

			union all
					select away_team as team,
					sum(away_runs) as score
				   from ipl
				group by away_team 
			) as sub
			 group by team)

select team,score 
from team_score where rnk=1;



-- Find the matches where the margin of victory was less than 10 runs.
select * from ipl
where abs(home_runs-away_runs)<10;


-- Calculate the average runs scored per over by each team.
with team_runs as (select 
        home_team as team,
        sum(home_runs) as total_home_runs,
        sum(home_overs) as total_home_overs,
        sum(away_runs) as total_away_runs,
        sum(away_overs) as total_away_overs
    from ipl
    group by  home_team 
    union all
    select away_team as team,
        sum(away_runs) as total_home_runs,
        sum(home_overs) as total_home_overs,
        sum(home_runs) as total_away_runs,
        sum(away_overs) as total_away_overs
    from  ipl
    group by  away_team 
)
select 
    team,
    round((total_home_runs + total_away_runs) * 1.0 / (total_home_overs + total_away_overs), 2) as average_runs_per_over
from
    team_runs;


-- Display the top 5 players with the highest number of Player of the Match awards.
select[Player of The Match],[Number of time player of the match]  from (
select pom as 'Player of The Match',
count(*) as 'Number of time player of the match',
dense_rank() over(order by count(*) desc) as rnk
from ipl 
group by pom ) x 
where rnk<=5



-- Find the venues where the average first inning score is greater than the average second inning score.

select venue_name as venue,average_score_1st_inning from(
select venue_name, avg(cast(
        case 
        when CHARINDEX('/', _1st_inning_score) > 0 
        then SUBSTRING(_1st_inning_score, 1, CHARINDEX('/', _1st_inning_score) - 1) 
        else _1st_inning_score 
        end 
    as int)) as average_score_1st_inning,
	avg(cast(
        case 
        when CHARINDEX('/', _2nd_inning_score) > 0 
        then SUBSTRING(_2nd_inning_score, 1, CHARINDEX('/', _2nd_inning_score) - 1) 
        else _2nd_inning_score 
        end 
    as int)) as average_score_2nd_inning
from ipl
group by venue_name) as x
where average_score_1st_inning>average_score_2nd_inning;


-- Calculate the win percentage of each team throughout all seasons.

with MatchCounts as (select team,sum(total_matches) as total_matches from (
    select 
        home_team AS team,
        COUNT(*) AS total_matches
     from ipl
    group by home_team
    union all
    select 
        away_team AS team,
        COUNT(*) AS total_matches
    from ipl
    group by away_team) as x
	group by team 

),
Wins as (
    select 
        winner as team,
        COUNT(*) as total_wins
    from ipl
    where  winner IS NOT NULL
    group by winner
)
select 
    mc.team,
    COALESCE(w.total_wins, 0) AS total_wins,
    mc.total_matches,
    ROUND((COALESCE(w.total_wins, 0) * 100.0) / mc.total_matches, 2) as win_percentage
from MatchCounts mc
left join Wins w on mc.team = w.team
order by win_percentage desc;



-- Determine the teams that have never played in a Super Over.
select team from(select home_team as team
from ipl where super_over=1
group by home_team
union 
select away_team as team 
from ipl 
where super_over=1
group by away_team ) as x
where team not in (
select home_team as team
from ipl where super_over=1
group by home_team
union 
select away_team as team 
from ipl 
where super_over=1
group by away_team )
;


-- Identify the matches where the same player was the captain for both home and away teams.
select * from ipl
where home_captain=away_captain;
