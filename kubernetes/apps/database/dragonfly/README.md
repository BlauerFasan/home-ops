# DragonflyDB

DragonflyDB is a modern Redis® replacement that's fully compatible with Redis and Memcached APIs, built from the ground up to utilize modern hardware with exceptional performance and efficiency.

## Features

- **Redis Compatibility**: Drop-in replacement for Redis with full API compatibility
- **Memcached Compatible**: Also supports Memcached protocol
- **Exceptional Performance**: 25x faster than Redis on a single instance
- **Multi-threaded**: Fully utilizes modern multi-core CPUs
- **Lower Memory**: Up to 30x more memory-efficient than Redis
- **Cluster Mode**: Native clustering support with automatic replication
- **Persistence**: Snapshotting and AOF (Append-Only File) support
- **No Forking**: Eliminates the fork-based save operations that cause latency spikes
- **TLS Support**: Built-in encryption for secure connections

## Architecture

### Deployment Components

1. **Dragonfly Operator**: Kubernetes operator for managing Dragonfly instances
2. **Dragonfly Cluster**: The actual Dragonfly database cluster

### Cluster Configuration

- **Image**: `ghcr.io/dragonflydb/dragonfly:v1.37.0`
- **Replicas**: 3 instances (matches cluster node count)
- **Cluster Mode**: Emulated mode for Redis compatibility
- **Threads**: 2 proactor threads per instance
- **Max Memory**: 512Mi per instance (auto-configured)

## Configuration

### Operator Settings

The Dragonfly Operator deployment includes:
- **Operator Version**: v1.4.0
- **Health Checks**: Liveness and readiness probes configured
- **Metrics**: Prometheus metrics exposed on port 8080
- **Security**: Runs as non-root user (65534) with minimal privileges
- **Topology Spread**: Ensures pods are distributed across nodes

### Cluster Settings

The Dragonfly cluster is configured with:
- **Lua Scripts**: `allow-undeclared-keys` flag enabled
- **Resource Requests**: 100m CPU per instance
- **Memory Limits**: 512Mi per instance
- **Auto-scaling**: Memory limit automatically exposed to Dragonfly

### Resource Requirements

**Per Instance:**
- CPU Request: 100m
- Memory Limit: 512Mi

**Operator:**
- CPU Request: 10m
- Memory Limit: 128Mi

## Access

- **Service Name**: `dragonfly.database.svc.cluster.local`
- **Port**: 6379 (Redis protocol)
- **Protocol**: Redis or Memcached

## Usage Examples

Connect using Redis CLI:
```bash
redis-cli -h dragonfly.database.svc.cluster.local -p 6379
```

Connect from application (Redis client):
```bash
redis://dragonfly.database.svc.cluster.local:6379
```

Set a key-value pair:
```bash
SET mykey "Hello DragonflyDB"
GET mykey
```

## Monitoring

### Metrics

The deployment includes:
- **ServiceMonitor**: Automatic Prometheus metrics scraping
- **Metrics Endpoint**: Available on port 8080 at `/metrics`
- **Scrape Interval**: 1 minute
- **PodMonitor**: Monitors individual Dragonfly pods

### Health Checks

Operator health endpoints:
- **Liveness**: `/healthz` on port 8081
- **Readiness**: `/readyz` on port 8081

### Status Monitoring

Using Gatus for external monitoring (configured in cluster deployment).

## Dependencies

The Dragonfly deployment depends on:
- **OpenEBS**: Requires OpenEBS storage to be ready

## Advantages Over Redis

1. **Performance**: Significantly faster, especially on multi-core systems
2. **Memory Efficiency**: Lower memory overhead
3. **No Forking**: Eliminates latency spikes during saves
4. **Vertical Scaling**: Better utilization of large instances
5. **Simplified Operations**: No need for Redis Cluster complexity

## Redis Command Compatibility

DragonflyDB supports most Redis commands including:
- String operations (GET, SET, INCR, etc.)
- List operations (LPUSH, RPUSH, LRANGE, etc.)
- Set operations (SADD, SMEMBERS, etc.)
- Sorted set operations (ZADD, ZRANGE, etc.)
- Hash operations (HSET, HGET, etc.)
- Pub/Sub messaging
- Transactions (MULTI/EXEC)
- Lua scripting
- Stream operations

## Notes

- Drop-in replacement for existing Redis workloads
- Fully compatible with Redis clients
- Cluster mode is emulated for Redis compatibility
- No need to modify application code
- Better performance characteristics than Redis

## Resources

- **Official Website**: https://www.dragonflydb.io
- **Documentation**: https://www.dragonflydb.io/docs
- **GitHub Repository**: https://github.com/dragonflydb/dragonfly
- **Operator Repository**: https://github.com/dragonflydb/dragonfly-operator
- **Docker Hub**: ghcr.io/dragonflydb/dragonfly
- **Benchmarks**: https://www.dragonflydb.io/blog/dragonfly-vs-redis
