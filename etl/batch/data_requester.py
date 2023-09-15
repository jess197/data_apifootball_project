from api_football import APIFootball

class DataRequester:

    def __init__(self):
        self.api = APIFootball()

    def request_events(self,league_id,start_date,end_date):
        return self.api.get('get_events',f'&from={start_date}&to={end_date}&league_id={league_id}')
