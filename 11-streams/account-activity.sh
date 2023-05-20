#!/usr/bin/env bash

calc() { awk "BEGIN { print $*}"; }

echo "FLUSHDB" | redis-cli 

getRandomAmount() {
    r=$(calc ${RANDOM}%1000-500)
    calc ${r}/100
}

while true
do
    credit1=$(getRandomAmount)
    credit2=$(getRandomAmount)
    debit1=$(getRandomAmount)
    debit2=$(getRandomAmount)

    echo "XADD account:1 * credit ${credit1} debit ${debit1}" | redis-cli 
    echo "XADD account:2 * credit ${credit2} debit ${debit2}" | redis-cli 
    sleep 2
done