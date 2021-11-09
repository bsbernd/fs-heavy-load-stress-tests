#!/bin/bash

source include-config.sh

ntfs3g_posix()
{
	local dir=${TESTROOT}/posix
	mkdir -p $dir
	cd $dir
	prove -r ${TESTS}/ntfs3g_posix/pjd-fstest-20080816
}


while [ /bin/true ]; do
	ntfs3g_posix
done
