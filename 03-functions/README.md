# Functions

## Install

```
cd 03-functions
./install-jlg.sh
./install-lrevrange.sh
redis-cli
```

## Play

```
fcall fibonacci 1 toto 10
lrange toto 0 -1
fcall lrevrange 1 toto -1 0
```

## Dump

```
function list
function dump
// copy the dump
function delete lrevrange
function delete jlg
function list
function restore <dump>
function list
function flush
```

## Kill

```
fcall sleep 0 20
```

In another `redis-cli`

```
function kill
```

## Statitics

Run the sleep function and in parallel, run a `function stats`.

```
fcall sleep 0 20
```

In another `redis-cli`

```
function stats
```
