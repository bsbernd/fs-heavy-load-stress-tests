#!/bin/sh

line=`ps axwwwww |grep screen | grep "S all_tests" | grep -v -E "grep | kill"`
export IFS="
"
for i in $line; do
	echo $i
	pid=`echo $i  | awk '{print $1'}`
	kill $pid
done
