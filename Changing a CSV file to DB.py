import pandas as pd
import sqlite3

df = pd.read_csv(
    r"the path where the file is in my computer",
    encoding="cp1252"
)

conn = sqlite3.connect("orders.db")

df.to_sql("orders", conn, if_exists="replace", index=False)

conn.close()

print("CSV successfully loaded into DB")

conn = sqlite3.connect("orders.db")

cursor = conn.cursor()
cursor.execute("SELECT COUNT(*) FROM orders")
print(cursor.fetchone())

conn.close()

import os
print(os.getcwd())