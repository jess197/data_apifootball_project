from sqlalchemy import create_engine
from sqlalchemy.dialects import registry
registry.register('snowflake', 'snowflake.sqlalchemy', 'dialect')

engine = create_engine(
    'snowflake://{user}:{password}@{account}/{db}/{schema}?warehouse={warehouse}'.format(
        user='****',
        password='****',
        account='****',
        warehouse='****',
        db='****',
        schema='****'
    )
)
