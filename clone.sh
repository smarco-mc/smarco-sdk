#!/bin/sh

SCRIPT=`(cd \`dirname $0\`; pwd)`
CLONEDIR=`(cd ${SCRIPT}/..; pwd)`/riscv-smarco

(
	rm -rf ${CLONEDIR}
	mkdir -p ${CLONEDIR}
	cd ${CLONEDIR}
	repo init -u https://github.com/smarco-mc/smarco-sdk \
		  -m tools/manifests/smarco.xml
	repo sync

	# Creating work bench
	repo start work --all
)
