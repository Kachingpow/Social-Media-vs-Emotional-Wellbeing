# STEP 1: Run the creation of the database and table (lines 5-19) in project_code.sql
# STEP 2: Run project_load_data.py
# STEP 3: Run the rest of project_code.sql

import pandas as pd
import numpy as np
import mysql.connector

def load_dataset(file_path):
    col_names = ['id', 'age', 'gender', 'platform', 'daily_usage', 'posts_per_day', 'likes_received_per_day', 'comments_received_per_day', 'messages_sent_per_day', 'dominant_emotion']
    df = pd.read_csv(file_path, header=None, names=col_names)

    expected_dtypes = {
        'id': 'int64',
        'age': 'int64',
        'gender': 'str',
        'platform': 'str',
        'daily_usage': 'int64',
        'posts_per_day': 'int64',
        'likes_received_per_day': 'int64',
        'comments_received_per_day': 'int64',
        'messages_sent_per_day': 'int64',
        'dominant_emotion': 'str'
    }

    #delete rows with unexpected values in any column:
    for col, expected_dtype in expected_dtypes.items():
        if expected_dtype == 'int64':
            df[col] = pd.to_numeric(df[col], errors='coerce')
        else:
            df.loc[df[col].apply(lambda x: str(x).isdigit()), col] = np.nan
    df = df.dropna()

    return df

def create_database_cursor(host, user, password, database):
    mydb = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )
    return mydb.cursor(), mydb

def insert_data(df, cursor, mydb):
    print(f"inserting {len(df)} rows")
    for i, row in df.iterrows():
        sql = """INSERT INTO social_db.social_stats(
            id,
            age,
            gender,
            platform,
            daily_usage,
            posts_per_day,
            likes_received_per_day,
            comments_received_per_day,
            messages_sent_per_day,
            dominant_emotion
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        val = tuple(row)
        cursor.execute(sql, val)
    mydb.commit()



#RUN:
file_path = 'C:/Users/rajpr/Documents/000 - Rutgers/Year 3/Summer 2024/Data Management/project_dataset/social_data.csv'

df = load_dataset(file_path)
cursor, mydb = create_database_cursor(host='localhost', user='root', password='password', database='social_db')
insert_data(df, cursor, mydb)

mydb.close()