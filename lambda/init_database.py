import sys
import logging
import rds_config
import pymysql

rds_host = ""
name = "usersdb"
password = 
db_name = "usersdb"

logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    conn = pymysql.connect(rds_host, user=name, passwd=password, db=db_name, connect_timeout=5)
except: pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")
def handler(event, context):
    """
    This function fetches content from MySQL RDS instance
    """

    item_count = 0

    with conn.cursor() as cur:

        newpwd = "ALTER USER 'root'@'localhost' IDENTIFIED BY '"#PASSWORD"'"
        newtab = "USE mysql; DROP TABLE IF EXISTS esidecra_user; CREATE TABLE esidecra_user ( id INT PRIMARY KEY NOT NULL, email VARCHAR(255) NOT NULL, familyname VARCHAR(255) NOT NULL, givenname VARCHAR(255) NOT NULL );"
        cur.execute(newtab)
        conn.commit()

    return "database set"
