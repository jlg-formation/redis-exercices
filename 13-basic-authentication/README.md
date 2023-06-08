# Basic Authentication

Redis configured by default has no authentication.

Basic Authentication is made by a password.
To add one, update the redis.conf file or set one with `CONFIG SET`.

This command set a global password to `toto123$`

```
config set requirepass toto123$
```

Any new connection to the Redis server will need to give the password before reading/writing any data:

```
auth toto123$
```

## Questions

1. Is the password given in cleartext on the network?
2. How to remove the password?
3. What is the name of the account when no ACL is configured?
