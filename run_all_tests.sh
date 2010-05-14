#!/bin/sh

dir=`pwd`
export PATH=$PATH:$dir

screen -dm -c ${dir}/screenrc
