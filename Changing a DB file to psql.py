import sqlite3
import pandas as pd
from sqlalchemy import create_engine

# Step 1, I load everything to the data base I have created in psql, allowing me to access the otherwise unaccesible csv data
sqlite_conn = sqlite3.connect("orders.db")
df = pd.read_sql_query("SELECT * FROM orders", sqlite_conn)
sqlite_conn.close()
print("STEP 1 OK", df.shape)



# Then push to PostgreSQL
pg_engine = create_engine(
    "postgresql+psycopg2://myusername:mypassword@localhost:5432/supply_chain"
)
df.to_sql("orders", pg_engine, if_exists="replace", index=False)
print("POSTGRES LOADED", df.shape)