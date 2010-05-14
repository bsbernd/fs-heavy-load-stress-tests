#!/bin/bash

source source_me.sh


ql_fstest()
{
	local dir=${TESTROOT}/ql-fstest
	mkdir -p $dir
	${TESTS}/ql-fstest/fstest $dir
}


ql_fstest

