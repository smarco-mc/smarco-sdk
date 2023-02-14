SUMMARY = "udev rules for SmarCo DUOWEN"
LICENSE = "GPL-2.0-only"

PR = "r1"

SRC_URI:freedom-u540 = "file://LICENSE.GPL2"

LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE.GPL2;md5=b234ee4d69f5fce4486a80fdaf4a4263"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/etc/udev/rules.d
}

COMPATIBLE_HOST = "riscv64.*"
COMPATIBLE_MACHINE = "duowen"
