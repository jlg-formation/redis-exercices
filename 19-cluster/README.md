# Cluster

## Concepts

Topology of a cluster:

- N master nodes. Data is sharded across the nodes.

- Every cluster node needs two TCP ports:

  - port for cluster administration
  - port for listening clients

- Each master should have at least one replica.

The cluster promote replica to master if needed without human intervention.

Configuration file `redis.conf`:

```
port 7000
# by default cluster-port will be equals to port + 10000
# If you want another port you need to be explicit.
cluster-port 27000
```

## Hash slot

For each key we can compute its hash slot (`hash slot = CRC16(key) % 16384`)

So there are 16384 hash slot.

Each master node of the cluster is assign a set of hash slots.

When nicely adding or removing node, the cluster automatically reassign the hash slots without manual intervention.

## Hash tags

If a key has `/\{.+\}/` regex then the string `S ` used to compute the hash slot will be the content between the first `{` and `}`:

`hash_slot = CRC16(S) % 16384`

## Limitations

1. Max 16384 master nodes.
2. If using multiple keys command all keys must be stored on the same node (ex: `DEL key [key ...]`).
   - same for transaction
   - same for lua script
3. If a master and all its replicas fail, then the cluster cannot work.
4. Strong consistency not assured. Reasons:
   - asynchronous replication
   - partition network

## Tutorial

use the `create-cluster.sh` script to play with cluser:

```
./create-cluster.sh
```

Start fresh nodes not in cluster:

```
./create-cluster.sh start
```

Create the cluster from these nodes:

```
./create-cluster.sh create
```

Stop the cluster nodes:

```
./create-cluster.sh stop
```

Clean all files:

```
./create-cluster.sh clean
```

Command to get all the keys of the cluster:

```
redis-cli --cluster call 127.0.0.1:30001 keys "*"
```
