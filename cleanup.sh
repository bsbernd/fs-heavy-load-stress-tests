#!/bin/bash

if [ "$1" = "-h" -o "$1" = "--help" ]; then
	echo
	echo "`basename $0` [ directory ]"
	echo
	echo "If the argument is empty, directory to clean up is" 
	echo "taken from source_me.sh."
	echo 
	exit 1
fi

set -e

dir=`dirname $0`
cd $dir

source include-config.sh

if [ -n "$1" ]; then
	TESTROOT="$1/`hostname`/"
fi	

for dir in fsstress1 fsstress2 fsstress3 ql-fstest posix; do
	rm -fr ${TESTROOT}/$dir &
done

wait

