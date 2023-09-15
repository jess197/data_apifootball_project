{{ config(materialized='view') }}
with teams as (
    select *
    from {{ ref('teams') }}
), match_goals as (
    select *
      from {{ ref('match_goals') }}
), matches as (
    select *
      from {{ ref('matches') }}
)
select t.team_name
     , count(away_goal) as goals 
  from teams t
  join matches m on m.match_awayteam_id = t.team_id
  join match_goals mg on  m.match_id = mg.match_id
where mg.away_goal = 1 
group by t.team_name
order by goals desc, team_name asc 
 



