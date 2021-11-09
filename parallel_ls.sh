#!/bin/bash

source include-config.sh

while [ /bin/true ]; do 
	 /bin/ls -l ${TESTROOT_PARALLEL}/append
	sleep 1
done
