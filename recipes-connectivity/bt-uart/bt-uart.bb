SUMMARY = "Broadcom Bluetooth UART attach service"
LICENSE = "CLOSED"
SRC_URI = "file://bt-uart.service"

inherit systemd

SYSTEMD_SERVICE:${PN} = "bt-uart.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/bt-uart.service \
        ${D}${systemd_system_unitdir}/bt-uart.service
}

FILES:${PN} += "${systemd_system_unitdir}/bt-uart.service"

RDEPENDS:${PN} += "bluez5"

