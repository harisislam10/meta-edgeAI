SUMMARY = "Auto connect to WiFi on boot"
DESCRIPTION = "Simple script to bring up wlan0 and connect using wpa_supplicant"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://wifi-autoconnect.sh \
            file://wifi-autoconnect.service \
            file://my_wifi_network.conf"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/wifi-autoconnect.sh ${D}${sbindir}/wifi-autoconnect.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/wifi-autoconnect.service ${D}${systemd_system_unitdir}/wifi-autoconnect.service

    # Create the base wpa_supplicant directory (if it doesn't already exist from the wpa-supplicant package)
    install -d ${D}${sysconfdir}/wpa_supplicant

    # !!! ADD THIS LINE !!!
    # Create the wpa_supplicant.conf.d subdirectory
    install -d ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant.conf.d

    # Install custom network config into wpa_supplicant's include directory
    install -m 0600 ${WORKDIR}/my_wifi_network.conf ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant.conf.d/my_wifi_network.conf
}

inherit systemd

SYSTEMD_SERVICE:${PN} = "wifi-autoconnect.service"

RDEPENDS:${PN} += "wpa-supplicant"