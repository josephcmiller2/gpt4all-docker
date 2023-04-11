#!/bin/sh

CPATH=$(realpath $(dirname "$0"))

. "${CPATH}/config"

EXTRAARGS="$EXTRAARGS -v ${CPATH}/files/hosts:/etc/hosts:rw"
EXTRAARGS="$EXTRAARGS -v ${CPATH}/env:/root/Auto-GPT/.env:rw"

if [[ "$1" == "" ]]; then
    #CMD=/bin/bash
    CMD=/usr/bin/startcontainer.sh
fi

podman run --hostname "${HOSTNAME}" --name "${NAME}" ${X11ARGS} ${FUSEARGS} ${SHAREDARGS} ${EXTRAARGS} "${TAGNAME}" /usr/sbin/init
podman exec ${RUNARGS} "${NAME}" "${CMD}" "$@"
podman stop "${NAME}"
podman rm "${NAME}"

