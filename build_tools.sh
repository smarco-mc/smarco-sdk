#!/bin/bash

SCRIPT=`(cd \`dirname $0\`; pwd)`
CLONEDIR=`(cd ${SCRIPT}/..; pwd)`/riscv-smarco
BUILDDIR=build

usage()
{
	echo "Usage:"
	echo "`basename $0` [-b build] [-d repo]"
	echo "Where:"
	echo " -b:          build directory under repo working directory"
	echo "              default $BUILDDIR"
	echo " -d:          repo working directory"
	echo "              default $CLONEDIR"
	exit $1
}

fatal_usage()
{
	echo $1
	usage 1
}

while getopts "b:d:" opt
do
	case $opt in
	b) BUILDDIR=$OPTARG;;
	d) CLONEDIR=$OPTARG;;
	?) echo "Invalid argument $opt"
	   fatal_usage;;
	esac
done
shift $(($OPTIND - 1))

echo "Working in ${CLONEDIR}..."
echo "Building tools in ${BUILDDIR}..."
(
	cd ${CLONEDIR}
	mkdir -p ${BUILDDIR}
	. ./smarco-sdk/setup.sh ${BUILDDIR}
	bitbake buildtools-extended-tarball
)
