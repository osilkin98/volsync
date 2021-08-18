#! /bin/bash
# creates a new replicationdestination with the earlier restoreasof time 
set -e -o pipefail

DATE_TIME_STRING=$(cat 22-timestamp.txt)

kubectl create -n "$NAMESPACE" -f - <<EOF
---
apiVersion: volsync.backube/v1alpha1
kind: ReplicationDestination
metadata:
  name: restore
spec:
  trigger:
    manual: restore-once
  restic:
    repository: restic-repo
    destinationPVC: data-dest
    copyMethod: None
    cacheCapacity: 1Gi
    restoreAsOf: ${DATE_TIME_STRING}
EOF
