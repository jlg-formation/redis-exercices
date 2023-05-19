# Sorted Set

## Introduction

A sorted set is like a set: It is a collection of items. But each items has a
score, which is a decimal number.

Inside the Redis database, the score is indexed so it is quick to retrieve items
by score.

## Questions

1. How I create a sorted set?
2. Can I see empty sorted set inside Redis?
3. How I update the score of an item inside a sorted set?
4. How I remove an item from a sorted set?
5. What is the command to know if a key is a sorted set?
6. How I list all the items of a sorted set?
7. How I count all the items with score between X stritcly and Y included in a
   sorted set?
8. What are the prefix of each sorted set command?

## Use case

Sorted set can be used for:

- kind of secondary index: score is the secondary index and the item is the primary index.
