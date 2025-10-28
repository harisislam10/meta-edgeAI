FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
inherit systemd

PACKAGECONFIG:append = " drm systemd"
PLYMOUTH_THEME = "mytheme"

SRC_URI += " \
    file://mytheme/background.png \
    file://mytheme/logo.png \
    file://mytheme/mytheme.script \
    file://mytheme/mytheme.plymouth \
    file://systemd/plymouth-delay.service \
"

SYSTEMD_SERVICE:${PN} += "plymouth-delay.service"

do_install:append() {
    # Install theme files
    install -d ${D}${datadir}/plymouth/themes/mytheme
    install -m 0644 ${WORKDIR}/mytheme/background.png ${D}${datadir}/plymouth/themes/mytheme/
    install -m 0644 ${WORKDIR}/mytheme/logo.png ${D}${datadir}/plymouth/themes/mytheme/
    install -m 0644 ${WORKDIR}/mytheme/mytheme.script ${D}${datadir}/plymouth/themes/mytheme/
    install -m 0644 ${WORKDIR}/mytheme/mytheme.plymouth ${D}${datadir}/plymouth/themes/mytheme/

    # Install systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/systemd/plymouth-delay.service ${D}${systemd_system_unitdir}

    # Set as default theme
    install -d ${D}${sysconfdir}/plymouth
    echo "[Daemon]" > ${D}${sysconfdir}/plymouth/plymouthd.conf
    echo "Theme=mytheme" >> ${D}${sysconfdir}/plymouth/plymouthd.conf
}

FILES:${PN} += "${datadir}/plymouth/themes/mytheme/* ${systemd_system_unitdir}/*"