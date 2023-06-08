# Users

Redis >=6

In Redis, managing users is done with ACL (Access Control List).

After connecting, the client gives a username and a password.
Each user has some limitation that can be configured before.

## List the existing users

```
ACL LIST
```

## Who am i?

```
ACL WHOAMI
```

## Create a user

```
ACL SETUSER alice
```

## Delete a user

```
ACL DELUSER alice
```

## Add a password to a user

```
ACL SETUSER alice >toto123$
```

Note: A user can have many password.

## Remove all password for a user

```
ACL SETUSER alice nopass
```

## Disable/Enable a user

```
ACL SETUSER alice on
ACL SETUSER alice off
```

## Authorize commands for a user

Give the right to use all commands:

To add command to a user, we generally uses categories.
A category is a set of command defined by Redis.

@<category>

```
ACL SETUSER alice +@all
```

## Authorize commands to use all keys

```
ACL SETUSER alice ~*
```

## List all categories

```
ACL CAT
```

## List the command inside a category

```
ACL CAT write
```

## Questions

1. How to create a new user in Redis?
2. How to add a password on a new user?
3. What is the name of the default user, when no one has been created?
4. How are stored the passwords inside Redis? What is the name of the algorithm?
5. Is it possible to add a password to a user by entering only its hash?
6. Is it possible to configure a user to have an access only in read only mode?
7. Can we have a list of all categories?
8. How to know what are the commands included in a category?
