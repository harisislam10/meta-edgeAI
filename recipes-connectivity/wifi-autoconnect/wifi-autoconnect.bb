SUMMARY = "WiFi Auto Connect on Boot"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://connect_wifi.sh \
    file://wifi-connect.service \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "wifi-connect.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

RDEPENDS:${PN} = "wpa-supplicant busybox-udhcpc"

do_install() {
    # Install the wifi script
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/connect_wifi.sh ${D}${bindir}/connect_wifi.sh

    # Install the systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/wifi-connect.service ${D}${systemd_system_unitdir}/wifi-connect.service
}

FILES:${PN} += " \
    ${bindir}/connect_wifi.sh \
    ${systemd_system_unitdir}/wifi-connect.service \
"
