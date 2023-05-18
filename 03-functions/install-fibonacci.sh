#!/usr/bin/env bash 

redis-cli -x FUNCTION LOAD REPLACE < fibonacci.lua