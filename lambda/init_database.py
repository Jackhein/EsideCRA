import sys
import logging
#import rds_config
import pymysql

import boto3
from botocore.exceptions import ClientError

region = 'eu-west-3'
db_name = "usersdb"
user = "admin"
ssm_parameter = 'usersdb_password'



## get password
def get_password(event, context):
    client_ssm = boto3.client('ssm')
    client_rds = boto3.client('rds', region_name=region)
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    try: 
        rds_host = client_rds.describe_db_instances(DBInstanceIdentifier=db_name).get('DBInstances')[0].get('Endpoint').get('Address');
        password = client_ssm.get_parameter(Name=ssm_parameter, WithDecryption=True).get('Parameter').get('Value');
        conn = pymysql.connect(rds_host, user=user, passwd=password, db=db_name, connect_timeout=5);
    except pymysql.MySQLError as e:
        logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
        logger.error(e)


## get endpoints

#def get_endpoint(event, context):
#    try:
##        conn = pymysql.connect(host=rds_host, port=3306, user=user, passwd=password, db='mysql', connect_timeout=5)
##        with conn.cursor() as cur:
##            cur.execute("some_SQL_script")
#    except Exception as ex:
#        print ex

## ping database

#try:
#    sys.exit()

#logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")
#def handler(event, context):
#    """
#    This function fetches content from MySQL RDS instance
#    """

#    item_count = 0

#    with conn.cursor() as cur:

#        newpwd = "ALTER USER 'root'@'localhost' IDENTIFIED BY '"#PASSWORD"'"
#        newtab = "USE mysql; DROP TABLE IF EXISTS esidecra_user; CREATE TABLE esidecra_user ( id INT PRIMARY KEY NOT NULL, email VARCHAR(255) NOT NULL, familyname VARCHAR(255) NOT NULL, givenname VARCHAR(255) NOT NULL );"
#        cur.execute(newtab)
#        conn.commit()

#    return "database set"
