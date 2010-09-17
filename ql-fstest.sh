#!/bin/bash

source source_me.sh


ql_fstest()
{
	local dir=${TESTROOT}/ql-fstest
	mkdir -p $dir
	${TESTS}/ql-fstest/fstest -p 99 $dir >${dir}/fstest${$}.log 2>${dir}/fstest${$}.err &
	tail -f ${dir}/fstest${$}.log
}


ql_fstest 

