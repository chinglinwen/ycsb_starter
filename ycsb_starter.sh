#!/bin/sh
#==============================================================
# DESCRIPTION: Execute all the ycsb testing at once
#               and generate results to parse for graph
#        FILE: ycsb_starter.sh
#       USAGE: ./ycsb_starter.sh [db.properties|-][time|-]
#                                [extra]
#      AUTHOR: Wen Zhenglin
#        DATE: 2016-8-16
#     VERSION: 1.0
#
# Notes:
#        workloadtype include a,b,c,d,e,f
# Revision history:
# 1.0		(2016-8-16)Created. 
#==============================================================

# specify db config file
db="$1"
if [ "x$db" = "x" -o "x$db" = "x-" ]; then
  echo "No db is specified, use default one"
  db="$( ls | grep properties | tail -1 )"
fi

# total time for the test in seconds( default 30 minutes )
time="$2"
if [ "x$time" = "x" -o "x$time" = "x-" ]; then
  time="1800"
fi

extra="$3"

# source functions ( it will setup the base directory )
. ./dotest_funcs.sh

# output control
log="$base/main.log"
echo "see the log $log"
exec 6>&1
exec >>$log
exec 2>>$log

# start testing all
echo "Start at: $( date +%F_%T )"
echo "Will run for total $time seconds"
echo

# start time counter
SECONDS=0

# do all workloads for a single count
start () {
  count="$1"

  workloads="a b c f d e"
  for j in $workloads; do
    starttest "$j" "$count" "$extra"
  done
}

# auto detect test
i=100
while true; do
  echo "$SECONDS seconds is passed"
  # check if out of time
  if [ $SECONDS -gt $time ]; then
    echo "Out of time now (for total $time seconds), no more test"
    break
  fi
  echo "$(( $time-$SECONDS)) seconds left"
  
  # do test
  echo "Starting count: $i"
  start $i

  case $i in
  100) step=100 ;;
  200) step=300 ;;
  500) step=500 ;;
  1000) step=1000 ;;
  esac
  
  i="$(( i + $step ))"
done

echo
echo "End at: $( date +%F_%T )"

exec 1>&6 6>&-
# end