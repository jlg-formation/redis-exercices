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

tls-cert-file ../tests/tls/server.crt
tls-key-file ../tests/tls/server.key
tls-ca-cert-file ../tests/tls/ca.crt
```

## Connect a client to redis

```
redis-cli -p 7000 --tls \
    --cert ../tests/tls/client.crt \
    --key ../tests/tls/client.key \
    --cacert ../tests/tls/ca.crt
```
