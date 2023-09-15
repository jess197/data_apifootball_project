{{ config(materialized='table') }}

WITH stg_match_lineups AS (
    SELECT *
    FROM {{ ref('stg_match_lineups') }}
),
players AS (
    SELECT DISTINCT
        team_id::int as team_id, 
        player_key::int AS player_id,
        lineup_player::VARCHAR(100) AS player_name,
        lineup_number::int as player_number,
        ROW_NUMBER() OVER (PARTITION BY player_key ORDER BY LENGTH(lineup_player) DESC) AS name_priority
    FROM stg_match_lineups
),
players_team AS (
    SELECT DISTINCT
        p.team_id,
        p.player_id,
        FIRST_VALUE(p.player_name) OVER (PARTITION BY p.player_id ORDER BY p.name_priority) AS player_name,
        p.player_number
    FROM players p
)
SELECT * FROM players_team
