#!/bin/bash

dir=`dirname $0`
cd $dir
export PATH=$PATH:$dir

source source_me.sh

for file in ${TESTROOT_PARALLEL}/*/ql-fstest/*.err; do
	if [ -s "$file" ]; then
		ls -l $file 
	fi
done

for file in ${TESTROOT_PARALLEL}/*/ql-fstest/*.log; do
	grep "eviction" $file
done


