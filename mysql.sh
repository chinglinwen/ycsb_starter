#!/bin/sh
#==============================================================
# DESCRIPTION: mysql sql executor
#              
#        FILE: mysql.sh
#       USAGE: ./mysql.sh
#      AUTHOR: Wen Zhenglin
#        DATE: 2016-8-25
#     VERSION: 1.0
#
# Revision history:
# 1.0		(2016-8-25)Created. 
#==============================================================

sqlcmd="mysql --skip-column-names -h 192.168.100.243 \
           -P 3307 -u wen -pwen123 -D ycsb"
msql () {
  $sqlcmd <<eof
  $@
eof
}
dosql="msql"

#$dosql "show tables;"
#
#$dosql "delete from usertable;" 
#$dosql "select count(*) from usertable;"

# end.