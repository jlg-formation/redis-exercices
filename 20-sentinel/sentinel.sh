#!/usr/bin/env bash
set -eau

start() {
    echo "starting 3 instances of redis: 1 master and 2 replicas"
    cat > redis-master.conf <<EOF
port 35000
daemonize yes
logfile 35000.log
EOF
    redis-server redis-master.conf

    cat > redis-replica-1.conf <<EOF
port 35001
daemonize yes
logfile 35001.log
replicaof 127.0.0.1 35000
repl-diskless-load on-empty-db
EOF
    redis-server redis-replica-1.conf

    cat > redis-replica-2.conf <<EOF
port 35002
daemonize yes
logfile 35002.log
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
    rm -f *.conf *.log
}

sentstart() {
    for PORT in 45000 45001 45002
    do
       cat > redis-sentinel-${PORT}.conf <<EOF
port ${PORT}
daemonize yes
logfile ${PORT}.log
sentinel monitor mymaster 127.0.0.1 35000 2
sentinel down-after-milliseconds mymaster 3000
sentinel failover-timeout mymaster 6000
sentinel parallel-syncs mymaster 1
EOF
        set -x
        redis-server redis-sentinel-${PORT}.conf --sentinel 
        set +x
    done


    
}

sentstop() {
    for PORT in 45000 45001 45002
    do
        set -x
        redis-cli -p ${PORT} shutdown || echo
        set +x
    done
}

help() {
    cat <<EOF
$0 start|stop|sentstart|sentstop|clear

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

    if [ "${1:-}" == "sentstart" ]; then
        sentstart
        exit 0
    fi

    if [ "${1:-}" == "sentstop" ]; then
        sentstop
        exit 0
    fi

    help
    exit 0

)
[ $? == 0 ] || {
    echo "Error..."
}