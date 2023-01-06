#!/bin/sh

SCRIPT=`(cd \`dirname $0\`; pwd)`
CLONEDIR=`(cd ${SCRIPT}/..; pwd)`/riscv-smarco
CNFGNAME="Lv Zheng <zhenglv@smart-core.cn>"
# repo commands
REPO_INIT=yes
REPO_START_WORK=yes
# repo related other operations
REINIT_REPO=no

usage()
{
	echo "Usage:"
	echo "`basename $0` [-d dir] [-f] [-n name] [-s] [-u]"
	echo "Where:"
	echo " -d:          repo working directory"
	echo "              default $CLONEDIR"
	echo " -f:          force removing directory and re-cloning"
	echo " -n:          repo configuration name"
	echo "              default $CNFGNAME"
	echo " -s:          start repo working branches"
	echo " -u:          upgrade repo with latest upstream"
	exit $1
}

fatal_usage()
{
	echo $1
	usage 1
}

while getopts "d:fn:su" opt
do
	case $opt in
	d) CLONEDIR=$OPTARG;;
	f) REINIT_REPO=yes
	   REPO_INIT=yes;;
	n) if [ "x$OPTARG" != "x${CNFGNAME}" ]; then
		CNFGNAME=$OPTARG
		CHNGCNFG=" --config-name"
	   fi;;
	s) REPO_START_WORK=yes;;
	u) REPO_INIT=no
	   REINIT_REPO=no;;
	?) echo "Invalid argument $opt"
	   fatal_usage;;
	esac
done
shift $(($OPTIND - 1))

echo "Configuring name to ${CNFGNAME}"
(
	if [ "x${REINIT_REPO}" = "xyes" ]; then
		echo "Removing ${CLONEDIR}..."
		rm -rf ${CLONEDIR}
		REPO_INIT=yes
	fi
	echo "Creating ${CLONEDIR}..."
	mkdir -p ${CLONEDIR}
	cd ${CLONEDIR}
	if [ "x${REPO_INIT}" = "xyes" ]; then
		echo "Initializing ${CLONEDIR}..."
		repo init ${CHNGCNFG} -u https://github.com/smarco-mc/smarco-sdk -m tools/manifests/smarco.xml
	else
		echo "Updating ${CLONEDIR}..."
		(cd smarco-sdk; git fetch github; git rebase github/main)
	fi
	repo sync
	if [ "x${REPO_START_WORK}" = "xyes" ]; then
		repo start work --all
	fi
)
