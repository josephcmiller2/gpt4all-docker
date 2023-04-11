#!/bin/bash

CPATH=$(realpath $(dirname "$0"))

. "${CPATH}/../config"

if [[ ! -f "${CPATH}/hosts" ]]; then
    cp /etc/hosts "${CPATH}/hosts"
fi

# Check if /etc/hosts already contains an entry for $HOSTNAME
if grep -q "^127\.0\.0\.1\s*$HOSTNAME" "${CPATH}/hosts"; then
  echo "Entry already exists in hosts for $HOSTNAME"
else
  # Append a new entry for $HOSTNAME to hosts
  echo "127.0.0.1    $HOSTNAME" | tee -a "${CPATH}/hosts" > /dev/null
  echo "Added new entry to hosts for $HOSTNAME"
fi

