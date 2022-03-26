#!/bin/bash

# vars
key=kakatototo
env=$1
type=$2
cluster=${3:-off}
log_path=log/$type/write_$env.log

# func
write () {
  key=$1
  val=$2
  cluster=$3

  date +"%Y/%m/%d %I:%M:%S" | tr '\n' '\t'
  echo -ne "$key: $i\t"
  if [ "$cluster" = "on" ]; then
    redis-cli -c -h localhost -p 16379 set $key $val 2>&1
  else
    redis-cli -h localhost -p 16379 set $key $val 2>&1
  fi
}

# main
for i in $(seq 1 3600); do
  write $key $i $cluster | tee -a $log_path
  sleep 1
done

