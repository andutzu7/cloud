import sys
import datetime
import logging
import pymysql
import subprocess
import os

#rds settings
rds_host  = "database-2.cshzicyg9d5b.us-east-1.rds.amazonaws.com"
name = "admin"
password = "ftOj45NRNkAGPeurcxn7"
db_name = "test"

logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    conn = pymysql.connect(host=rds_host, user=name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

def parse_row(row):

    template = f"<div class='article'><h3 class='subtitle'>{row[1]}</h3><p><small>{row[2]} - {row[3]}</small> </p> </div>"

    with open("tmp","w+") as f:
        f.write(template)

    rc = subprocess.call("./insert_article_in_index.sh")

    os.remove("tmp")



def handler():
    """
    This function fetches content from MySQL RDS instance
    """
    print("SUCCESS: Connection to RDS MySQL instance succeeded")

    item_count = 0

    with conn.cursor() as cur:
        cur.execute("select * from news")
        for row in cur:
            item_count += 1
            logger.info(row)
            parse_row(row)
    conn.commit()

if __name__ == "__main__":
    handler()
