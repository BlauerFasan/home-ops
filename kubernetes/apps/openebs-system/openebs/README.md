# OpenEBS

OpenEBS is a Cloud Native Storage platform that provides persistent storage for Kubernetes workloads. It converts any storage available on the Kubernetes nodes into local or replicated Kubernetes Persistent Volumes.

## Overview

This deployment uses OpenEBS in **Local PV Hostpath** mode, which provides simple, efficient, and fast local storage for Kubernetes applications. It's ideal for applications that don't require replication or need high-performance local storage.

## Features

- **Dynamic Provisioning**: Automatically creates PersistentVolumes on demand
- **Hostpath Storage**: Uses local node storage for maximum performance
- **Kubernetes Native**: Fully integrated with Kubernetes storage APIs
- **CSI Compliant**: Container Storage Interface (CSI) driver
- **No External Dependencies**: Works with any Kubernetes cluster
- **Simple Management**: Easy to deploy and maintain
- **High Performance**: Direct access to local storage without network overhead

## Deployment Configuration

### Enabled Components

- **Local PV Hostpath Provisioner**: Provides dynamic local storage provisioning

### Disabled Components

The following OpenEBS features are **disabled** in this deployment:
- **Alloy**: Monitoring agent
- **LVM LocalPV**: Logical Volume Manager-based storage
- **ZFS LocalPV**: ZFS-based storage engine
- **Mayastor**: Replicated storage engine
- **Volume Snapshots**: Snapshot functionality
- **Loki**: Log aggregation
- **MinIO**: Object storage

### Storage Configuration

**Hostpath Storage Class:**
- **Name**: `openebs-hostpath`
- **Base Path**: `/var/openebs/local`
- **Default Class**: No (not set as cluster default)
- **Provisioner**: OpenEBS Dynamic Local PV provisioner

### Image Configuration

Uses images from **Quay.io** registry:
- Provisioner: `quay.io/openebs/provisioner-localpv`
- Helper Pod: Uses Quay.io registry

## Usage

### Creating a PersistentVolumeClaim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-app-storage
  namespace: default
spec:
  storageClassName: openebs-hostpath
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```

### Using in a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: my-app-storage
```

## Storage Location

All data is stored on the node's local filesystem at:
```
/var/openebs/local/<pv-name>/
```

## Characteristics

### Advantages

- **High Performance**: Direct local disk access, no network overhead
- **Simple Setup**: Minimal configuration required
- **No Dependencies**: No external storage systems needed
- **Cost Effective**: Uses existing node storage
- **Low Latency**: Best latency characteristics for local workloads

### Limitations

- **No Replication**: Data exists only on one node
- **No HA**: If the node fails, data is unavailable
- **Pod Affinity**: Pods are bound to the node where data resides
- **No Snapshots**: Volume snapshot feature is disabled

## Suitable Use Cases

OpenEBS Hostpath is ideal for:
- Development and testing environments
- CI/CD pipelines and build caches
- Databases like DragonflyDB where replication is handled at the application level
- Stateful applications with their own HA mechanisms
- High-performance workloads requiring low latency
- Non-critical data that can tolerate node failures

## Not Suitable For

Avoid using Hostpath storage for:
- Critical data requiring HA without application-level replication
- Data that must survive node failures
- Workloads requiring volume migration between nodes
- Production databases without application-level HA

## Monitoring

The deployment includes:
- Automatic updates via Reloader when configuration changes
- Standard Kubernetes events and logs
- Integration with cluster monitoring (if configured)

## Dependencies

This deployment serves as a dependency for:
- **Dragonfly**: Requires OpenEBS for persistent storage

## Access

- **Storage Class Name**: `openebs-hostpath`
- **Namespace**: `openebs-system`
- **Provisioner**: `openebs.io/local`

## Notes

- Data persists on the node's local disk
- PVs are automatically created when PVCs are created
- Storage size is limited by node's available disk space
- Consider node disk capacity when planning storage requirements
- For production workloads requiring HA, consider using replicated storage solutions

## Resources

- **Official Website**: https://openebs.io
- **Documentation**: https://openebs.io/docs
- **GitHub Repository**: https://github.com/openebs/openebs
- **LocalPV Docs**: https://openebs.io/docs/concepts/localpv
- **Helm Charts**: https://openebs.github.io/charts
- **Container Images**: quay.io/openebs
