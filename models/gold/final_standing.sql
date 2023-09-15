{{ config(materialized='view') }}
with teams as (
    select *
    from {{ ref('teams') }}
), matches as (
    select *
      from {{ ref('matches') }}
), 
final_table as (
select t.team_name 
     , count(t.team_id) as matches_played
     , sum(CASE WHEN match_hometeam_score > match_awayteam_score THEN 1 ELSE 0 END) as won 
     , sum(CASE WHEN match_hometeam_score = match_awayteam_score THEN 1 ELSE 0 END) as draw 
     , sum(CASE WHEN match_hometeam_score < match_awayteam_score THEN 1 ELSE 0 END) as lost 
     , sum(match_hometeam_score) as goals_scored
     , sum(match_awayteam_score) as goals_conceded
     , sum(CASE WHEN match_hometeam_score > match_awayteam_score THEN 3 
                WHEN match_hometeam_score = match_awayteam_score THEN 1
                WHEN match_hometeam_score < match_awayteam_score THEN 0 END) as points 
  from teams t
  join matches m_home on m_home.match_hometeam_id = t.team_id
  group by t.team_name
union 
select t.team_name 
     , count(t.team_id) as matches_played
     , sum(CASE WHEN match_hometeam_score < match_awayteam_score THEN 1 ELSE 0 END) as won 
     , sum(CASE WHEN match_hometeam_score = match_awayteam_score THEN 1 ELSE 0 END) as draw 
     , sum(CASE WHEN match_hometeam_score > match_awayteam_score THEN 1 ELSE 0 END) as lost 
     , sum(match_awayteam_score) as goals_scored
     , sum(match_hometeam_score) as goals_conceded
     , sum(CASE WHEN match_hometeam_score < match_awayteam_score THEN 3 
                WHEN match_hometeam_score = match_awayteam_score THEN 1
                WHEN match_hometeam_score > match_awayteam_score THEN 0 END) as points 
  from teams t
  join matches m_away on m_away.match_awayteam_id = t.team_id
  group by t.team_name
)

select team_name 
     , sum(matches_played) as matches_played
     , sum(won) as won 
     , sum(draw) as draw 
     , sum(lost) as lost 
     , sum(goals_scored) as goals_scored
     , sum(goals_conceded) as goals_conceded
     , sum(points) as points 
  from final_table
  group by team_name
  order by points desc, (goals_scored - goals_conceded) desc, goals_scored desc, goals_conceded asc, won desc 



