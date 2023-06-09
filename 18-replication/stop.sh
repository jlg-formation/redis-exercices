#!/usr/bin/env bash
set -eau

set +e
(
    set -e
    
    redis-cli -p 7000 shutdown
    redis-cli -p 7001 shutdown

    ps -aux | grep redis-server | grep -v grep
)
[ $? != 0 ] && {
    echo "Error..."
}