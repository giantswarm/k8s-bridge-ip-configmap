#!/bin/bash

set -eu

NETWORK_BRIDGE_IP=$(/sbin/ifconfig ${NETWORK_BRIDGE_NAME} | grep 'inet ' | awk '{print $2}')
echo "Using network bridge IP '${NETWORK_BRIDGE_IP}'."

cat << EOF > ${BRIDGE_IP_CONFIGMAP_PATH}
{"apiVersion": "v1","kind": "ConfigMap","metadata": {"name": "${BRIDGE_IP_CONFIGMAP_NAME}", "namespace": "${K8S_NAMESPACE}"},"data": {"bridge-ip": "${NETWORK_BRIDGE_IP}"}}
EOF

echo "Generated config map for network bridge IP."
cat ${BRIDGE_IP_CONFIGMAP_PATH}
