{{ config(materialized='view') }}
with match_cards as (
    select *
    from {{ ref('match_cards') }}
), matches as (
    select *
      from {{ ref('matches') }}
)

select mt.match_referee
     , COUNT(mc.card_type) as total_cards
  from matches mt
  left join match_cards mc on mc.match_id = mt.match_id 
  group by mt.match_referee
  order by total_cards desc 
  limit 5




