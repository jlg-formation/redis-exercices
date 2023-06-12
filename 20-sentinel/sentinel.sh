#!/usr/bin/env bash
set -eau

start() {
    echo "starting 3 instances of redis: 1 master and 2 replicas"
    cat > redis-master.conf <<EOF
port 35000
daemonize yes
EOF
    redis-server redis-master.conf

    cat > redis-replica-1.conf <<EOF
port 35001
daemonize yes
replicaof 127.0.0.1 35000
repl-diskless-load on-empty-db
EOF
    redis-server redis-replica-1.conf

    cat > redis-replica-2.conf <<EOF
port 35002
daemonize yes
replicaof 127.0.0.1 35000
repl-diskless-load on-empty-db
EOF
    redis-server redis-replica-2.conf
}

stop() {
    redis-cli -p 35000 shutdown nosave || echo
    redis-cli -p 35001 shutdown nosave || echo
    redis-cli -p 35002 shutdown nosave || echo
}

clear() {
    rm -f *.conf
}

sentstart() {
    cat > redis-sentinel-1.conf <<EOF
port 45000
daemonize yes
sentinel monitor mymaster 127.0.0.1 35000 2
sentinel down-after-milliseconds mymaster 3000
sentinel failover-timeout mymaster 6000
sentinel parallel-syncs mymaster 1
EOF
}

sentstop() {
    redis-cli -p 35000 shutdown nosave || echo
}

help() {
    cat <<EOF
$0 start|stop

start: Start 1 master and 2 replicas
stop: stop all redis instances
clear: Erase all generated files (*.conf, etc.)

sentstart: Start 3 sentinels
EOF
}

set +e
(
    set -e

    if [ "${1:-}" == "start" ]; then
        start
        exit 0
    fi

    if [ "${1:-}" == "stop" ]; then
        stop
        exit 0
    fi
    
    if [ "${1:-}" == "clear" ]; then
        clear
        exit 0
    fi

    help
    exit 0

)
[ $? == 0 ] || {
    echo "Error..."
}