# Replication

Purpose:

- increase high availability
- manage failover

Idea:

- having one master server
- and many replica servers

Replica should be readonly server.
In fact, master should not be used to read but to write.

Replica can have subreplica. So we could have a tree structure with one master at the root.

Speed: All

# Configuration

## Master

nothing.

## Replica

in redis.conf:

```
# replicaof <hostname> <port>
replicaof 127.0.0.1 7000
```

Important Note: on some linux configuration (ex: Windows WSL) we need one more config on replica:

```
repl-diskless-load on-empty-db
```

In the following part, master listen for 7000 and replica listen for 7001.

## Spy with tcpdump

### Install tcpdump

```
sudo apt-get update
sudo apt-get install tcpdump
tcpdump --version
```

### Spy the ping connection of replica

In the official redis doc, it is indicated:

> Redis replicas ping the master every second, acknowledging the amount of replication stream processed.

Open a tcpdump on master port:

```
sudo  tcpdump -A -i lo port 7000
```

See that every seconds, there is activity on the socket.

### Spy a initial full sync of a replica

Start a fresh master.
Add 2 or 3 string keys. (titi, toto, tata)

```
sudo  tcpdump -A -i lo port 7000
```

Remove the dump.rdb of the replica if any.
Start a fresh replica

Look at the initial sync:

```
replica>>> PING
master<<< PONG


>>> REPLCONF listening-port 7001
<<< OK



>>> REPLCONF capa eof capa psync2
<<< OK


>>> PSYNC ? -1
<<< FULLRESYNC 4af7360b506843f9346c234825cbf3a4dfffe375 2614
$EOF:e9c991d24c3e00573f4727f543d1ca3e22e23f0e
REDIS0010.      redis-ver.7.0.11.
redis-bits.@..ctime../.d..used-mem.......repl-stream-db....repl-id(4af7360b506843f9346c234825cbf3a4dfffe375..repl-offset.6
..aof-base.........xx.yy..titi.toto..toto.tutu..P.8..u;e9c991d24c3e00573f4727f543d1ca3e22e23f0e

// and then every seconds:

>>> REPLCONF ACK 2614
>>> REPLCONF ACK 2614
>>> REPLCONF ACK 2614
>>> REPLCONF ACK 2614
>>> REPLCONF ACK 2614

```

## Spy a write command on master

Connect to master and set a key.
You will see the key that is sent to the replica as is, added with the database number.

```
>>> SELECT 0
>>> set qq ww
```

# Questions

1. How to set a replica if the default user needs a password?
2. How to set a replica with a specific ACL account?
3. Why removing persistence on the master is a bad idea?

## End
