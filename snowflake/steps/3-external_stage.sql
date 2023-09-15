CREATE SCHEMA IF NOT EXISTS EXTERNAL_STAGES; 
USE SCHEMA EXTERNAL_STAGES;

---- ## APIFOOTBALL PREMIER LEAGUE EVENTS ## ----

CREATE OR replace STAGE EXTERNAL_STAGES.PREMIER_LEAGUE_EVENTS_STAGE_S3
    URL = '' -- bucket URL s3://my_bucket_name
    STORAGE_INTEGRATION = AWS_S3_INTEGRATION; 

LIST @MANAGE_DB.EXTERNAL_STAGES.PREMIER_LEAGUE_EVENTS_STAGE_S3;

DESC STAGE PREMIER_LEAGUE_EVENTS_STAGE_S3;

SHOW STAGES; 