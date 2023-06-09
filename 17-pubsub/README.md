# Publish Subscribe

A sender publish a message to a channel.
A receiver subscribe to a channel.

## Sender

```
PUBLISH <channel> <message>
```

## Receiver

```
SUBSCRIBE <channel>
```

If you want to subscribe to many channels with pattern matching, use `PSUBSCRIBE`.

## Questions

1. How to subscribe at the same time to many channels?
2. How the sender does know how many receivers received a message?
3.
