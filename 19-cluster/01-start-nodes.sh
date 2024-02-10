#!/usr/bin/env bash
set -eau

. ./config.sh

rm -rf ${CLUSTER_DIR}
mkdir -p ${CLUSTER_DIR}

for ((c = 1; c <= ${NODES}; c++))
do  
   NODE_PORT=$((PORT+c))
   echo "port ${NODE_PORT}"
   cat <<EOF > ${CLUSTER_DIR}/redis-${NODE_PORT}.conf
port ${NODE_PORT}
cluster-enabled yes
cluster-config-file nodes-${NODE_PORT}.conf
cluster-node-timeout $TIMEOUT
appendonly yes
appendfilename appendonly-${NODE_PORT}.aof
appenddirname appendonlydir-${NODE_PORT}
dbfilename dump-${NODE_PORT}.rdb
logfile ${NODE_PORT}.log
daemonize yes
repl-diskless-load on-empty-db
# Add other options here if you want


EOF

(
    cd ${CLUSTER_DIR}
    redis-server redis-${NODE_PORT}.conf
)
done



