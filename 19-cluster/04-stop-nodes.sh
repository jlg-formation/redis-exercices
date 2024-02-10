#!/usr/bin/env bash
set -eau

. ./config.sh

set +e
for ((c = 1; c <= ${NODES}; c++))
do 
    (
        NODE_PORT=$((PORT+c))
        echo "Stopping ${NODE_PORT}"
        redis-cli -p ${NODE_PORT} shutdown nosave
    )
done
