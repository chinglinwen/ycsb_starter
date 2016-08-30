#!/bin/sh
#==============================================================
# DESCRIPTION: To create database ycsb
#              
#        FILE: create_database.sh
#       USAGE: ./create_database.sh <sql-executor>
#      AUTHOR: Wen Zhenglin
#        DATE: 2016-8-30
#     VERSION: 1.0
#
# Revision history:
# 1.0		(2016-8-30)Created. 
#==============================================================

sql="
create database ycsb;
CREATE TABLE usertable (
    YCSB_KEY VARCHAR(255) PRIMARY KEY,
    FIELD0 TEXT, FIELD1 TEXT,
    FIELD2 TEXT, FIELD3 TEXT,
    FIELD4 TEXT, FIELD5 TEXT,
    FIELD6 TEXT, FIELD7 TEXT,
    FIELD8 TEXT, FIELD9 TEXT
);
"

# provide the sql executor to source
. ./$@

$dosql "$sql"

echo "show tables"
$dosql "show tables;"

echo "show count"
$dosql "select count(YCSB_KEY) from usertable;"

echo "done"

# end.