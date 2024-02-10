# TLS

## Install OpenSSL

OpenSSL is a tool allowing to create public/private keys and certificates.

```
sudo apt update
sudo apt install openssl
```

## Generate the certificates

To run a TLS connection

1. the client needs 3 files:

- a client public/private key file.
- a client certificate from a root CA
- a self signed certificate of the root CA.

2. the server needs also 3 files:

- a server public/private key file.
- a server certificate from a root CA
- a self signed certificate of the root CA.

Theses files can be generated with `openssl`.
There is a script `gen-test-certs.sh` given by redis to do that with ease.

## Run Redis

`redis.conf`:

```
port 0
tls-port 7000
daemonize yes

tls-cert-file ../path/to/server.crt
tls-key-file ../path/to/server.key
tls-ca-cert-file ../path/to/ca.crt
```

## Connect a client to redis

```
redis-cli -p 7000 --tls \
    --cert ../path/to/client.crt \
    --key ../path/to/client.key \
    --cacert ../path/to/ca.crt
```

### Spy with tcpflow

`tcpflow` is better than `tcpdump` in developer experience. You can forget the datagram tcp header and see only the flushed info on the socket.

```
sudo apt-get update
sudo apt-get install tcpflow
tcpflow --version
```

```
sudo tcpflow -i lo port 7000
```
