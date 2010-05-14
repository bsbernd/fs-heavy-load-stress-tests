#!/bin/sh

DIR=$1

trap "killall `basename $0`" SIGINT SIGTERM

if [ -z "$DIR" ]; then
	echo "usage: `basename $0` [directory]"
	exit 1
fi


mkdir -p $DIR
FILE=${DIR}/file

for job in `seq 1 32`; do
(
	while [ 1 ] ; do
		echo "$$-$job" >> $FILE
	done
) &
done

wait
