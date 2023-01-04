#!/bin/sh

SCRIPT=`(cd \`dirname $0\`; pwd)`
CLONEDIR=`(cd ${SCRIPT}/..; pwd)`/riscv-smarco
BUILDDIR=${CLONEDIR}/build

(
	cd ${CLONEDIR}
	mkdir -p ${BUILDDIR}
	. ./openembedded-core/oe-init-build-env ${BUILDDIR}
	bitbake buildtools-extended-tarball
)
