FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://os-release"

do_install:append() {
    install -m 0644 ${WORKDIR}/os-release ${D}${sysconfdir}/os-release
}

