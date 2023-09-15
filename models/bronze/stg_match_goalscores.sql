{{ config(materialized='table') }}
with source_events as (

    select RAW_FILE
      from RAW.PREMIER_LEAGUE_EVENTS

)
select 
     r.value:match_id as match_id
    ,g.value:time as goal_time 
    ,g.value:home_scorer as home_scorer
    ,g.value:home_scorer_id as home_scorer_id
    ,g.value:home_assist as home_assist
    ,g.value:home_assist_id as home_assist_id
    ,g.value:score as score
    ,g.value:away_scorer as away_scorer
    ,g.value:away_scorer_id as away_scorer_id
    ,g.value:away_assist as away_assist
    ,g.value:away_assist_id as away_assist_id
    ,g.value:info as info
    ,g.value:score_info_time as score_info_time
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r
,lateral flatten(input => r.value, path => 'goalscorer' ) g
where r.value:match_status = 'Finished'