#!/bin/bash

set -eu

NETWORK_BRIDGE_IP=""

while :; do
  NETWORK_BRIDGE_IP=$(/sbin/ifconfig ${NETWORK_BRIDGE_NAME} | grep 'inet ' | awk '{print $2}' | cut -d ':' -f 2)
  if [ ! -z "${NETWORK_BRIDGE_IP}" ]; then
    break
  fi
  sleep 1
done

echo "Found network bridge IP '${NETWORK_BRIDGE_IP}' for network bridge name '${NETWORK_BRIDGE_NAME}'."

cat <<EOF >${BRIDGE_IP_CONFIGMAP_PATH}
NETWORK_BRIDGE_IP=${NETWORK_BRIDGE_IP}
EOF

echo "Created env file for network bridge IP."
cat ${BRIDGE_IP_CONFIGMAP_PATH}
