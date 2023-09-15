{{ config(materialized='table') }}
with source_events as (

    select RAW_FILE
      from RAW.PREMIER_LEAGUE_EVENTS

)
select 
     r.value:match_id as match_id
    ,r.value:country_id as country_id
    ,r.value:country_name as country_name
    ,r.value:league_id as league_id
    ,r.value:league_name as league_name
    ,r.value:match_date as match_date
    ,r.value:match_status as match_status
    ,r.value:match_time as match_time
    ,r.value:match_hometeam_id as match_hometeam_id
    ,r.value:match_hometeam_name as match_hometeam_name
    ,r.value:match_hometeam_score as match_hometeam_score
    ,r.value:match_awayteam_name as match_awayteam_name
    ,r.value:match_awayteam_id as match_awayteam_id
    ,r.value:match_awayteam_score as match_awayteam_score
    ,r.value:match_hometeam_halftime_score as match_hometeam_halftime_score 
    ,r.value:match_awayteam_halftime_score as match_awayteam_halftime_score
    ,r.value:match_hometeam_extra_score as match_hometeam_extra_score
    ,r.value:match_awayteam_extra_score as match_awayteam_extra_score
    ,r.value:match_hometeam_penalty_score as match_hometeam_penalty_score 
    ,r.value:match_awayteam_penalty_score as match_awayteam_penalty_score
    ,r.value:match_hometeam_ft_score as match_hometeam_ft_score
    ,r.value:match_awayteam_ft_score as match_awayteam_ft_score
    ,r.value:match_hometeam_system as match_hometeam_system
    ,r.value:match_awayteam_system as match_awayteam_system
    ,r.value:match_live as match_live
    ,r.value:match_round as match_round
    ,r.value:match_stadium as match_stadium 
    ,r.value:match_referee as match_referee
    ,r.value:league_year as league_year
    ,r.value:fk_stage_key as fk_stage_key
    ,r.value:stage_name as stage_name
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r