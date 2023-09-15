{{ config(materialized='table') }}
with stg_matches as (
    select *
    from {{ ref('stg_matches') }}
)
select match_id::int as match_id 
     , match_round::VARCHAR(2) as match_round
     , DATE(TO_TIMESTAMP(match_date::STRING, 'YYYY-MM-DD')) as match_date
     , match_time::VARCHAR(5) as match_time
     , match_status::VARCHAR(10) as match_status
     , match_hometeam_id::int as match_hometeam_id
     , match_awayteam_id::int as match_awayteam_id
     , match_hometeam_score::int as match_hometeam_score
     , match_awayteam_score::int as match_awayteam_score
     , match_stadium::VARCHAR(100) as match_stadium
     , match_referee::VARCHAR(100) as match_referee
     , DATE(TO_TIMESTAMP(ingestion_date::STRING,'YYYY/MM/DD HH24:MI:SS')) as ingestion_date
  from stg_matches 
 where match_status = 'Finished'
