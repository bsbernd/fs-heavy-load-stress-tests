#!/bin/bash

set -e

dir=`dirname $0`
cd $dir

source source_me.sh

for dir in fsstress1 fsstress2 fsstress3 ql-fstest posix; do
	rm -fr $dir &
done

wait

