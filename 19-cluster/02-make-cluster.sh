#!/usr/bin/env bash
set -eau

. ./config.sh

HOSTS=""
for ((c = 1; c <= ${NODES}; c++))
do 
    NODE_PORT=$((PORT+c))
    HOSTS="$HOSTS $CLUSTER_HOST:$NODE_PORT"
done
   
redis-cli --cluster create $HOSTS --cluster-replicas $REPLICAS --cluster-yes
