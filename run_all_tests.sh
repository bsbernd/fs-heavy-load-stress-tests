#!/bin/sh

set -e

dir=`dirname $0`
cd $dir
export PATH=$PATH:$dir

if [ -z "$1" ]; then
	echo 
	echo "usage: `basename $0` <directory>"
	echo
	exit 1
fi

RUNDIR="$1"

cat <<EOF >source_me.sh
#!/bin/bash

TESTS=`pwd`

STRESSTIME=1200 # time in hours
TESTROOT_PARALLEL=${RUNDIR}
TESTROOT=${RUNDIR}/\`hostname\`
EOF

make

echo "Starting tests in screen session"
screen -S all_tests -dm -c ${dir}/screenrc
