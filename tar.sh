#!/bin/bash

source include-config.sh

while [ 1 -eq 1 ]; do
        tar cvf -  ${TESTROOT_PARALLEL} >/dev/null
done

