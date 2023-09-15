{{ config(materialized='table') }}
with source_events as (

    select RAW_FILE
      from RAW.PREMIER_LEAGUE_EVENTS

)
select 
     r.value:match_id as match_id
    ,c.value:time as card_time 
    ,c.value:home_fault as home_fault
    ,c.value:card as card_type
    ,c.value:away_fault as away_fault
    ,c.value:info as info 
    ,c.value:home_player_id as home_player_id
    ,c.value:away_player_id as away_player_id 
    ,c.value:score_info_time as score_info_time
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r
,lateral flatten(input => r.value, path => 'cards' ) c
where r.value:match_status = 'Finished'