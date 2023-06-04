# Configuration

When starting a redis server, here is the command:

```
redis-server
```

We can optionally but it is always the case start it with a config file

```
redis-server redis.conf
```

If you want to discover all the files installed by apt for redis, just do:

```
dpkg -L redis-server
```

You will see the `/etc/redis/redis.conf` file used for configuring the redis-server installed as a service.

[You can see the copy of this file here](./redis.conf)

[See the Example of a redis-conf using the port 7000](./7000/redis.conf).

## Questions

1. How many settings does the `redis.conf` file provided by default contains?
2. How to change the port the server is listening?
3. How to start a server in background task mode?
4. How to start a server that listen only the loopback interface 127.0.0.1?
5. Can we shutdown a redis server from a client using another network interface than the loopback interface?
