SUMMARY = "Murata Type 2BC (CYW4373) Wi-Fi and Bluetooth firmware"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = "file://cyfmac4373-sdio.2BC.txt;md5=19b21a45ad1174545fb14992e3aa5dd8  \
                    file://cyfmac4373-sdio.clm_blob;md5=ea7b2ed3706236b5c218ff1f4df7fbc7 \
                    file://cyfmac4373-sdio.bin;md5=c51ffab9a60c5d49db12e09869488162"

# Point to your local firmware files
SRC_URI = "file://cyfmac4373-sdio.bin \
           file://cyfmac4373-sdio.clm_blob \
           file://cyfmac4373-sdio.2BC.txt"

# If a separate BT firmware file is needed, add it here:
# SRC_URI += " file://BCM4373A0.hcd"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${nonarch_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/cyfmac4373-sdio.bin ${D}${nonarch_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/cyfmac4373-sdio.2BC.txt ${D}${nonarch_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/cyfmac4373-sdio.clm_blob ${D}${nonarch_libdir}/firmware/brcm/


    # If separate BT firmware:
    # install -m 0644 ${WORKDIR}/BCM4373A0.hcd ${D}${nonarch_libdir}/firmware/brcm/
}

# Change the path to /usr/lib/firmware/brcm/*
FILES:${PN} = "${nonarch_libdir}/firmware/brcm/*"