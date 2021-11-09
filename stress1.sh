#!/bin/bash

source include-config.sh

fsstress1()
{
	local dir=${TESTROOT}/fsstress1
	mkdir -p $dir
	cd ${TESTS}/fsstress
	./script1 $STRESSTIME $dir
}


fsstress1

