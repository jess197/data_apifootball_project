import pandas as pd
from config import engine

def create_csv(query, csv_path):
    df = pd.read_sql_query(query, engine)
    df.to_csv(csv_path, index=False)  

csv_path = 'csv/query_a.csv'
query = "SELECT * FROM FOOTBALL_DATA_GOLD.FINAL_STANDING"
create_csv(query, csv_path)

query = "SELECT * FROM FOOTBALL_DATA_GOLD.teams_per_goals_scored_away"
csv_path = 'csv/query_b.csv'
create_csv(query, csv_path)

query = "SELECT * FROM FOOTBALL_DATA_GOLD.top_five_refeeres_most_cards"
csv_path = 'csv/query_c.csv'
create_csv(query, csv_path)

query = "SELECT * FROM FOOTBALL_DATA_GOLD.top_three_goal_scorers_until_round_14"
csv_path = 'csv/query_d.csv'
create_csv(query, csv_path)