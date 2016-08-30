#!/bin/sh
#==============================================================
# DESCRIPTION: ycsb dotest funcs
#              
#        FILE: dotest_funcs.sh
#       USAGE: . ./dotest_funcs.sh
#      AUTHOR: Wen Zhenglin
#        DATE: 2016-8-22
#     VERSION: 1.0
#
# Revision history:
# 1.0		(2016-8-22)Created. 
#==============================================================

IsExist () {
  file="$1"
  ls "$1" >/dev/null
  if [ $? -ne 0 ]; then
    return 1
  fi
}

# define db outside
#db="../conf/db.properties"
if ! IsExist "$db" ; then
  echo "db conf $db not exists"
  return 1
fi

dbname="$( basename $db | awk '{ print $1 }' FS='.' )"
base="Results.$dbname.$( date +%Y%m%d_%H%M%S )"
#base="Results.d"
mkdir "$base" 2>/dev/null

# to get dosql function
. ./$dbname.sh
if [ $? -ne 0 ]; then
  echo "Can't source dosql function, can't do sql delete"
  exit 1
fi

# setenv
# the parent dir is ycsb home
cmd="../bin/ycsb"
load="$cmd load jdbc -P $db -s"
run="$cmd run jdbc -P $db -s"

#batch="-p db.batchsize=1000 -p jdbc.fetchsize=20 -p jdbc.autocommit=true"
#

delete () {
  $dosql "delete from usertable;"
  cnt="$( $dosql "select count(YCSB_KEY) from usertable;" )"
  cnt="$( echo "$cnt" | grep -v -e row -e count )"
  echo "deleted, current count is: $cnt"
}

load () {
  k="$1"
  count="$2"
  extra="$3"
  
  wk="../workloads/workload$k"
  if ! IsExist "$wk" ; then
    echo "workload $wk not exists"
    return 1
  fi
  
  suffix="$( echo $k | tr 'a-z' 'A-Z' )"
  f="$base/$dbname-Workload$suffix-$count.load"

  $load -P $wk -p recordcount=$count $extra > "$f"
}

run () {
  k="$1"
  count="$2"
  extra="$3"
  
  echo "For $dbname start workload$k test..."
  suffix="$( echo $k | tr 'a-z' 'A-Z' )"
  f="$base/$dbname-Workload$suffix-$count.result"
  
  wk="../workloads/workload$k"
  if ! IsExist "$wk" ; then
    echo "workload $wk not exists"
    return 1
  fi
  
  histgram="-p recordcount=$count -p operationcount=$count"
  param="-P $wk $histgram"
  if [[ $- == *i* ]]; then
    f="/dev/stdout"
  fi
  
  $run $param $extra > "$f"
  echo "Workload$k test done."
  echo
}

# provide workload type, count, and or extra
starttest () {
  k="$1"
  count="$2"
  extra="$3"
  
  if [ "x$k" = "xa" -o "x$k" = "xe" ]; then
    delete "$k" "$count" "$extra"
    load "$k" "$count" "$extra"
  fi
  
  run "$k" "$count" "$extra"
}

# example
#starttest a 100
#starttest a 100 extra-param
