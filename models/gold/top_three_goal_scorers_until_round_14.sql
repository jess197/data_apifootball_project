{{ config(materialized='view') }}
with players as (
    select *
    from {{ ref('players') }}
), teams as (
    select *
      from {{ ref('teams') }}
), match_goals as (
        select *
      from {{ ref('match_goals') }}
), matches as (
     select *
      from {{ ref('matches') }}
)
select p.player_name
     , t.team_name 
     , count(mg.scorer_id) as goals 
  from players p 
  join teams t on p.team_id = t.team_id
  join match_goals mg on mg.scorer_id = p.player_id
  join matches m on mg.match_id = m.match_id
  where m.match_round <= 14
  group by p.player_name, team_name
  order by goals desc
  limit 3 




