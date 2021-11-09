#!/bin/bash

source include-config.sh

LOG_DIR="${HOME}/tmp/fstests/${HOSTNAME}/"
mkdir -p ${LOG_DIR}

ql_fstest()
{
	local dir=${TESTROOT}/ql-fstest
	mkdir -p $dir
	${TESTS}/ql-fstest/fstest -p 90 $dir >${LOG_DIR}/fstest${$}.log 2>${LOG_DIR}/fstest${$}.err \
        --max-files=1000 &
	tail -f ${LOG_DIR}/fstest${$}.log
}


ql_fstest 

