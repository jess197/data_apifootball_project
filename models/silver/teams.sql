{{ config(materialized='table') }}

WITH stg_matches AS (
    SELECT *
    FROM {{ ref('stg_matches') }}
),
home_teams AS (
    SELECT DISTINCT
        match_hometeam_id::int AS team_id,
        match_hometeam_name::VARCHAR(50) AS team_name
    FROM stg_matches
),
team_names AS (
    SELECT
        team_id,
        team_name,
        ROW_NUMBER() OVER (PARTITION BY team_id ORDER BY LENGTH(team_name) DESC) AS name_priority
    FROM home_teams
)
SELECT DISTINCT
    ht.team_id,
    FIRST_VALUE(tn.team_name) OVER (PARTITION BY ht.team_id ORDER BY tn.name_priority) AS team_name
FROM home_teams ht
JOIN team_names tn
ON ht.team_id = tn.team_id
