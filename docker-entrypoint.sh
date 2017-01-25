#!/bin/bash

set -eu

NETWORK_BRIDGE_IP=$(/sbin/ifconfig ${NETWORK_BRIDGE_NAME} | grep 'inet ' | awk '{print $2}')

echo "Using network bridge IP '${NETWORK_BRIDGE_IP}'"

cat << EOF > /tmp/bridge-ip-configmap-${SUFFIX_CONFIGMAP}.json
{"apiVersion": "v1","kind": "ConfigMap","metadata": {"name": "bridge-ip-configmap-${SUFFIX_CONFIGMAP}", "namespace": "${K8S_NAMESPACE}"},"data": {"bridge-ip": "${NETWORK_BRIDGE_IP}"}}
EOF

echo "Generated config map for network bridge IP"
cat /tmp/bridge-ip-configmap-${SUFFIX_CONFIGMAP}.json
