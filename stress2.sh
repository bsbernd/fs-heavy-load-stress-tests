#!/bin/bash

source source_me.sh

fsstress2()
{
	local dir=${TESTROOT}/fsstress2
	mkdir -p $dir
	cd ${TESTS}/fsstress
	./script2 $STRESSTIME $dir
}


fsstress2

