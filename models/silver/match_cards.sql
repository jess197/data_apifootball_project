{{ config(materialized='table') }}
with stg_match_cards as (
    select *
    from {{ ref('stg_match_cards') }}
)
select match_id::int as match_id 
     , card_time::VARCHAR(5) as card_time
     , card_type::VARCHAR(15) as card_type
     , CASE WHEN home_fault = '' THEN away_fault ELSE home_fault::VARCHAR(100) END as player_name
     , CASE WHEN away_player_id != '' THEN away_player_id::int 
            WHEN home_player_id != '' THEN home_player_id::int
            ELSE NULL END as player_id
  from stg_match_cards