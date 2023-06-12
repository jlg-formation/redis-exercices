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

help() {
    cat <<EOF
$0 start|stop

start: Start 1 master and 2 replicas
stop: stop all redis instances
clear: Erase all generated files (*.conf, etc.)
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