#!/bin/bash

rmmod_driver()
{
	name=$1
	
	pdsh -a lsmod |grep $name >/dev/null
	if [ $? -eq 0 ]; then
		pdsh -a rmmod $name 2>&1 | grep -v -E "does not exist in | ssh exited with"
	fi
}

stop_start()
{
	echo "`date` Stopping resource"
	cluster_resources stop >/dev/null
	res="xxx"
	while [ -n "$res" ]; do
		res=`crm_mon -1 -r | grep lustre | grep Started >/dev/null`
		sleep 1
	done

	count=0
	out="xxx"
	while [ -n "$out" -a $count -lt 90 ]; do
		out=`pdsh -a "lustre_rmmod" 2>&1  |grep "Modules still loaded"`
		sleep 1
		count=$(($count + 1))
	done
	if [ -n "$out" ]; then
		echo "Failed to unload Lustre modules"
	fi

	# we want to make sure nothing is saved in memory anymore
	multipath -F
	rmmod_driver qla2xxx
	rmmod_driver sfablkdrvr
	# TODO: stop IB, other drivers

	pdsh -a modprobe qla2xxx
	pdsh -a modprobe sfablkdrvr

	sleep 20
	echo "Cleanup"
	cluster_resources cleanup >/dev/null
	sleep 5
	echo "`date` Starting resources"
	cluster_resources start >/dev/null
	res="xxx"
	while [ -n "$res" ]; do
		res=`crm_mon -1 -r | grep lustre | grep Stopped >/dev/null`
		sleep 1
	done
}

failover()
{
	nodes="$@"


	echo "`date` : Standby $nodes"
	for node in $nodes; do
		crm node standby $node
	done
	# TODO: check with crm_mon, but difficult with shell, so use python
	#       or perl

	# give it some time to write data

	sleep 1200

	for node in $nodes; do
		crm node online $node
	done
	echo "`date` : Online $nodes"
}

stonith()
{
	nodes="$@"
	echo "`date` : Fence $nodes"
	for node in $nodes; do
		crm node fence $node
	done
	for node in $nodes; do
		res="xxx"
		count=0
		while [ -n "$res" -a $count -lt 120 ]; do
			res=`crm_mon -1 -r | grep $node | grep online >/dev/null`
			sleep 1
			count=$(($count + 1))
		done
		if [ -n "$res" ]; then
			echo "Failed to fence $node"
		fi
	done

	fail=0
	for node in $nodes; do
		res="xxx"
		count=0
		while [ -n "$res" -a $count -lt 1200 ]; do
				res=`crm_mon -1 -r | grep $node | grep OFFLINE >/dev/null`
				sleep 1
				count=$(($count + 1))
		done
		if [ -n "$res" ]; then
			echo "Failed to online $node"
		fi
	done
	echo "`date` : End of fence $nodes"
}

while [ /bin/true ]; do
	stonith vm1 vm2
	sleep 1200
	stonith vm3 vm6
	sleep 1200
	stonith vm7 vm1
	# Do not stonith vm8, as this scripts runs on it
	sleep 1200
	stop_start
	sleep 1200
	failover vm1 vm2 vm3
	sleep 1200
	failover vm6 vm7 vm8
	sleep 1200
done

