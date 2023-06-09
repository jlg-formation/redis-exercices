# Geospatial indexes

First you store many geographical coordinates (latitude, longitude).
Then you search for them.

- inside a circle (center + radius)
- inside a rectangle (corner defined - topleft and bottomright)

A geospatial index is a sorted set.

## Adding data

```
GEOADD <key> <longitude> <latitude> <name>
```

```
TYPE <geospatial_index_key>
zset
```

Example:

```
127.0.0.1:6379> geoadd titi 2.6398020090410492 48.84813175327884 chezmoi
(integer) 1
127.0.0.1:6379> geoadd titi 2.6436490030607365 48.84947166092137 boulot
(integer) 1
127.0.0.1:6379> geodist titi chezmoi boulot m
"318.5834"
```

## Search for data

- Within a circle:

```
GEOSEARCH <key> FROMLONLAT <longitude> <latitude> BYRADIUS <length> km WITHDIST
```

- Within a rectangle

```
GEOSEARCH <key> FROMLONLAT <longitude> <latitude> BYBOX <width> <height> km WITHDIST
```

## Geohash string

Encoding via a string of a location (longitude and latitude)
In France with 11 characters alphanumeric we can encode a location with less than 1m of precision.

https://en.wikipedia.org/wiki/Geohash

```
GEOHASH titi chezmoi
```

## Exercices

- How works the BYBOX settings? What is the width, length? Where is the <longitude> <latitude> in the rectangle?
- How to search inside a polygon using geohash?
