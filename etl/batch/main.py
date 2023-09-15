from data_requester import DataRequester
from data_uploader import DataUploader
import json 
from datetime import timedelta, datetime

requester = DataRequester()
uploader = DataUploader()

def get_date():
    date_hour_now = datetime.now()
    return date_hour_now

def get_date_format_json(date):
    date_hour_formated = date.strftime("%Y/%m/%d %H:%M:%S")
    return date_hour_formated

def process_events(start_date, end_date):
    response = requester.request_events(152,start_date,end_date)

    ingestion_date = get_date_format_json(date=get_date())
    event_data = {
        'ingestion_date' : ingestion_date,
        'data': response
    }
    json_data = json.dumps(event_data)

    file_name = f'events_premier_league/events_{start_date}_{end_date}.json'

    uploader.upload_file_to_S3(file_name,json_data)
    
 


process_events('2022-08-01','2022-11-11')
process_events('2022-11-12','2023-05-29')