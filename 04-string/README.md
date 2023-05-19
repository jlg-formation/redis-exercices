# Redis String

## Introduction

```
redis-cli
```

CRUD on keys

```
keys *
set titi toto
keys *
get titi
del titi
keys *
```

Note: to pop a key, use GETDEL

## Exercices

### Adding a TTL to a key

```
flushdb
keys *
set titi toto EX 30
keys *
ttl titi
ttl titi
ttl titi
// wait 30s
set titi tutu KEEPTTL
// the KEEPTTL option do not reset the TTL
keys *
```

### Counter

```
incr counter
incr counter
incr counter
decr counter
get counter
incrby counter 10
decrby counter 5
```

Note: counter needs to be an integer to work well with `incr`, `decr`, etc.

```
incrbyfloat counter 0.5
incrbyfloat counter -0.5
```

### Manipulating the string content

```
set titi toto
append titi tutu
```

Note : no command allows prefixing.

SUBSTR is replaced by GETRANGE

STRLEN to get the string length

## Use case

Caching with or without TTL:

- SQL Request
- URL Request
- Session object

## Questions

1. What is the max size for the key in redis?
2. What is the max size for a string value in redis?
