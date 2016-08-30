#!/bin/sh
#==============================================================
# DESCRIPTION: cockroachdb sql executor
#              
#        FILE: cockroachDB.sh
#       USAGE: ./cockroachDB.sh
#      AUTHOR: Wen Zhenglin
#        DATE: 2016-8-25
#     VERSION: 1.0
#
# Revision history:
# 1.0		(2016-8-25)Created. 
#==============================================================

# for cockroachdb
url="$( which cockroach )"
g="/opt/glibc/build"
p="$g:$g/math:$g/elf:$g/dlfcn:$g/nss:$g/nis:$g/rt:$g/resolv:$g/crypt:$g/nptl:$g/dfp"
GCONV_PATH=$g/iconvdata LC_ALL=C
cockroachcmd="$g/elf/ld.so --library-path $p $url"

purl="postgresql://192.168.100.241:4001/ycsb?sslmode=disable"
sqlcmd="$cockroachcmd sql --url=$purl -d ycsb"

csql () {
  $sqlcmd <<eof
  $@
eof
}

dosql="csql"

#$dosql "show tables;"
#$dosql "select count(*) from usertable;"

# end.