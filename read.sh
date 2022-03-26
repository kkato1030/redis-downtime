#!/bin/bash

# vars
key=kakatototo
env=$1
type=$2
log_path=log/$type/read_$env.log

# func
read () {
  key=$1
  cluster=$2

  date +"%Y/%m/%d %I:%M:%S" | tr '\n' '\t'
  echo -n "$key: "
  if [ "$cluster" = "on" ]; then
    redis-cli -c -h localhost -p 16379 get $key 2>&1 | tr -d '"'
  else
    redis-cli -h localhost -p 16379 get $key 2>&1 | tr -d '"'
  fi
}

# main
for i in $(seq 1 3600); do
  read $key $cluster | tee -a $log_path
  sleep 1
done
