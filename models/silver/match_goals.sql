{{ config(materialized='table') }}
with stg_match_goalscores as (
    select *
    from {{ ref('stg_match_goalscores') }}
)
select match_id::int as match_id 
     , CASE WHEN away_scorer_id <> '' THEN 1 ELSE 0 END as away_goal            
     , goal_time::VARCHAR(5) as goal_time
     , score::VARCHAR(6) as score
     , CASE WHEN away_scorer_id = '' THEN home_scorer_id::int ELSE away_scorer_id::int END as scorer_id
  from stg_match_goalscores