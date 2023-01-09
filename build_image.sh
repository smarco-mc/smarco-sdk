#!/bin/bash

SCRIPT=`(cd \`dirname $0\`; pwd)`
CLONEDIR=`(cd ${SCRIPT}/..; pwd)`/riscv-smarco
BUILDDIR=build
MACHINE=qemuriscv64

usage()
{
	echo "Usage:"
	echo "`basename $0` [-b build] [-d repo] [-m machine]"
	echo "Where:"
	echo " -b:          build directory under repo working directory"
	echo "              default $BUILDDIR"
	echo " -d:          repo working directory"
	echo "              default $CLONEDIR"
	echo " -m:          specify machine type"
	echo "              default $MACHINE"
	exit $1
}

fatal_usage()
{
	echo $1
	usage 1
}

while getopts "b:d:m:" opt
do
	case $opt in
	b) BUILDDIR=$OPTARG;;
	d) CLONEDIR=$OPTARG;;
	m) MACHINE=$OPTARG;;
	?) echo "Invalid argument $opt"
	   fatal_usage;;
	esac
done
shift $(($OPTIND - 1))

echo "Working in ${CLONEDIR}..."
echo "Building image in ${BUILDDIR}..."
(
	cd ${CLONEDIR}
	mkdir -p ${BUILDDIR}
	cd build
	. ./smarco-sdk/setup.sh ${BUILDDIR}
	MACHINE=${MACHINE} bitbake demo-coreip-cli
)
