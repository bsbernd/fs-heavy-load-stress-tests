#!/bin/bash

source include-config.sh

fsstress2()
{
	local dir=${TESTROOT}/fsstress2
	mkdir -p $dir
	cd ${TESTS}/fsstress
	./script2 $STRESSTIME $dir
}


fsstress2

