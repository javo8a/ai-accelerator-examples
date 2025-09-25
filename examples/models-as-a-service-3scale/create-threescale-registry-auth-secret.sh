#!/usr/bin/env bash

set -euo pipefail

# Extract existing cluster pull secret
PULL_SECRET=$(oc extract secret/pull-secret -n openshift-config --keys=.dockerconfigjson --to=- | base64 -w 0)

# Create secret using HEREDOC
oc apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: threescale-registry-auth
  namespace: 3scale
  annotations:
    argocd.argoproj.io/sync-options: "Prune=false"
    argocd.argoproj.io/compare-options: "IgnoreExtraneous"
  labels:
    rhoai-example: maas
    rhoai-example-component: 3scale
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: ${PULL_SECRET}
EOF

echo "Secret created successfully"
