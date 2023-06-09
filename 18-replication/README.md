# Replication

Purpose:

- increase high availability
- manage failover

Idea:

- having one master server
- and many replica servers

Replica should be readonly server.
In fact, master should not be used to read but to write.

# Configuration

## Master
