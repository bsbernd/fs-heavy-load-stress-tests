#!/bin/sh

DIR=$(dirname $0)

while  [ ! -e ${DIR}/source_me.sh ]; do
    sleep 5
done

while [ -z "${TESTS}" ]; do
    source ${DIR}/source_me.sh
done
