#######------------------#######
#######CONFIGURATION-API#######
#######------------------######

import os 
import requests

class APIFootball: 

    def __init__(self): 
        self.base_api_url = 'https://apiv3.apifootball.com/'
        self.api_key=os.getenv('API_KEY')

    def get(self,action,query_string):
        response = requests.get(f'{self.base_api_url}?action={action}{query_string}&APIkey={self.api_key}')
        return response.json()

