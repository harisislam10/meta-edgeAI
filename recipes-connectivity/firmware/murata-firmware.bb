SUMMARY = "Murata Type 2BC (CYW4373) Wi-Fi and Bluetooth firmware"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = "file://cyfmac4373-sdio.2BC.txt;md5=19b21a45ad1174545fb14992e3aa5dd8  \
                    file://brcmfmac4373-sdio.bin;md5=8c1b0d6e2a4c7f9d8b0c1e3f5a2b6c7d \
                    file://brcmfmac4373.bin;md5=2b1c8d4e5f6a7b8c9d0e1f2a3b4c5d6e \
                    file://cyfmac4373-sdio.bin;md5=7037c91f7e1af046439917f4f4368875"

# Point to your local firmware files
SRC_URI = "file://cyfmac4373-sdio.bin \
           file://brcmfmac4373-sdio.bin \
           file://brcmfmac4373.bin \
           file://cyfmac4373-sdio.2BC.txt"

# If a separate BT firmware file is needed, add it here:
# SRC_URI += " file://BCM4373A0.hcd"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${nonarch_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/cyfmac4373-sdio.bin ${D}${nonarch_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/cyfmac4373-sdio.2BC.txt ${D}${nonarch_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/brcmfmac4373-sdio.bin ${D}${nonarch_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/brcmfmac4373.bin ${D}${nonarch_libdir}/firmware/brcm/


    # If separate BT firmware:
    # install -m 0644 ${WORKDIR}/BCM4373A0.hcd ${D}${nonarch_libdir}/firmware/brcm/
}

# Change the path to /usr/lib/firmware/brcm/*
FILES:${PN} = "${nonarch_libdir}/firmware/brcm/*"