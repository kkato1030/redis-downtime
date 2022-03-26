#!/bin/bash

# vars
env=$1
type=$2
log_path=log/$type/info_$env.log

. ./_common.sh

# func
info () {
  date +"%Y/%m/%d %I:%M:%S" | tr '\n' '\t'
  redis-cli -h $host -p $port info 2>&1 | grep redis_version
}

# main
for i in $(seq 1 3600); do
  info  | tee -a $log_path
  sleep 1
done
