{{ config(materialized='table') }}
with source_events as (

    select RAW_FILE
      from RAW.PREMIER_LEAGUE_EVENTS

)
select 
     r.value:match_id as match_id
    ,r.value:match_hometeam_id as team_id
    ,lh.value:lineup_player as lineup_player
    ,lh.value:lineup_number as lineup_number
    ,lh.value:lineup_position as lineup_position
    ,lh.value:player_key as player_key
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r
,lateral flatten(input => r.value, path => 'lineup.home.starting_lineups' ) lh
where r.value:match_status = 'Finished'
UNION
select 
     r.value:match_id as match_id
    ,r.value:match_awayteam_id as team_id
    ,la.value:lineup_player as lineup_player
    ,la.value:lineup_number as lineup_number
    ,la.value:lineup_position as lineup_position
    ,la.value:player_key as player_key
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r
,lateral flatten(input => r.value, path => 'lineup.away.starting_lineups' ) la
where r.value:match_status = 'Finished'
UNION
select 
     r.value:match_id as match_id
    ,r.value:match_hometeam_id as team_id
    ,lhs.value:lineup_player as lineup_player
    ,lhs.value:lineup_number as lineup_number
    ,lhs.value:lineup_position as lineup_position
    ,lhs.value:player_key as player_key
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r
,lateral flatten(input => r.value, path => 'lineup.home.substitutes' ) lhs
where r.value:match_status = 'Finished'
UNION
select 
     r.value:match_id as match_id
    ,r.value:match_awayteam_id as team_id
    ,las.value:lineup_player as lineup_player
    ,las.value:lineup_number as lineup_number
    ,las.value:lineup_position as lineup_position
    ,las.value:player_key as player_key
    ,se.RAW_FILE:ingestion_date as ingestion_date
from source_events se
,lateral flatten(input => se.RAW_FILE, path => 'data') r
,lateral flatten(input => r.value, path => 'lineup.away.substitutes' ) las
where r.value:match_status = 'Finished'

