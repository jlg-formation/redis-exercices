# Hyperloglog

## Introduction

The French algorithm hyperloglog allows to compute the cardinality of a set
using probabilistic computation.

- Advantage: in Redis, it takes 12kb of memory.
  The cardinality computation is O(1)
- Inconvenient: It does not remember each of the set items. The cardinality is precise at 0.81%.

## Use cases

Count of very big set.
Example: Log of activity on a service.
nbr of connection during a day. Different IP connected, Different user, etc.

## Questions

In Redis:

1. How to create a hyperloglog?
2. How to recognize a hyperloglog key?
3. How to count the cardinality of an hyperloglog?
4. How to merge to hyperloglog?
