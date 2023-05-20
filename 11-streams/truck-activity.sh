#!/usr/bin/env bash

calc() { awk "BEGIN { print $*}"; }

truck1Lat=23.4567
truck2Lat=22.3412

echo "FLUSHDB" | redis-cli 

while true
do
    
    r=$(calc ${RANDOM}%1000-500)
    incr=$(calc ${r}/1000)
    
    truck1Lat=$(calc ${truck1Lat}+${incr})
    truck2Lat=$(calc ${truck2Lat}+${incr})
    echo "XADD truck:1 * battery_level 99.9 lat ${truck1Lat} long 12.12345 alt 102 driver JLG" | redis-cli 
    echo "XADD truck:2 * battery_level 34.5 lat ${truck2Lat} long 12.12345 alt 102 driver JLG" | redis-cli 
    sleep 2
done