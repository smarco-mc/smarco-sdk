#!/bin/sh

SCRIPT=`(cd \`dirname $0\`; pwd)`
CLONEDIR=`(cd ${SCRIPT}/..; pwd)`/riscv-smarco
CNFGNAME="Lv Zheng <zhenglv@smart-core.cn>"

usage()
{
	echo "Usage:"
	echo "`basename $0` [-d dir] [-f] [-n name] [-s]"
	echo "Where:"
	echo " -d:          repo working directory"
	echo "              default $CLONEDIR"
	echo " -f:          force removing directory and re-cloning"
	echo " -n:          repo configuration name"
	echo "              default $CNFGNAME"
	echo " -s:          start repo working branches"
	exit $1
}

fatal_usage()
{
	echo $1
	usage 1
}

while getopts "d:fn:s" opt
do
	case $opt in
	d) CLONEDIR=$OPTARG;;
	f) FORCERMD=yes;;
	n) if [ "x$OPTARG" != "x${CNFGNAME}" ]; then
		CNFGNAME=$OPTARG
		CHNGCNFG=" --config-name"
	   fi;;
	s) STARTWBR=yes;;
	?) echo "Invalid argument $opt"
	   fatal_usage;;
	esac
done
shift $(($OPTIND - 1))

echo "Configuring name to ${CNFGNAME}"
(
	if [ "x${FORCERMD}" = "xyes" ]; then
		echo "Removing ${CLONEDIR}..."
		rm -rf ${CLONEDIR}
	fi
	echo "Creating ${CLONEDIR}..."
	mkdir -p ${CLONEDIR}
	cd ${CLONEDIR}
	repo init ${CHNGCNFG} -u https://github.com/smarco-mc/smarco-sdk -m tools/manifests/smarco.xml
	repo sync
	if [ "x${STARTWBR}" = "xyes" ]; then
		repo start work --all
	fi
)
