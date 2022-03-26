#!/bin/bash

# vars
key=kakatototo
env=$1
type=$2
log_path=log/$type/write_$env.log

# func
write () {
  key=$1
  val=$2

  date +"%Y/%m/%d %I:%M:%S" | tr '\n' '\t'
  echo -ne "$key: $i\t"
  redis-cli -h localhost -p 16379 set $key $val 2>&1
}

# main
for i in $(seq 1 3600); do
  write $key $i | tee -a $log_path
  sleep 1
done

