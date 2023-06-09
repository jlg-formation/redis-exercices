#!/usr/bin/env bash
set -eau

set +e
(
    set -e
    
    cd 7000
    redis-server redis.conf

    cd ..
    cd 7001
    redis-server redis.conf

    ps -aux | grep redis-server | grep -v grep
)
[ $? != 0 ] && {
    echo "Error..."
}