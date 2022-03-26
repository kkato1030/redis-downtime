#!/bin/bash
host=$1
bastion=$2
ssh -L 16379:$host:6379 $2
