#!/bin/bash

source source_me.sh

while [ /bin/true ]; do 
	 /bin/ls -l ${TESTROOT_PARALLEL}/append
	sleep 1
done
