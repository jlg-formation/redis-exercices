#!/usr/bin/env bash
set -eau

. ./config.sh

# connect to the 30001 and set titi toto
# kill the cluster where titi is
# connect to the 30001 again and get titi
# Test passed if you received toto

FIRST_NODE=$((PORT+1))
redis-cli -c -p ${FIRST_NODE} set titi toto

redis-cli -c -p ${FIRST_NODE} CLUSTER KEYSLOT titi
# The key titi should be on cluster node 30003

# We kill 30003
redis-cli -c -p 30003 shutdown nosave

echo "get titi..."
set +e
response=
until [ "${response}" = "toto" ] 
do
  echo "Try again"
  response=$(redis-cli -c -p ${FIRST_NODE} get titi)
  echo response=${response}
  sleep 0.2
done


