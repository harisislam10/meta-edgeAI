SUMMARY = "Murata Type 2BC (CYW4373) Wi-Fi and Bluetooth firmware"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = "file://cyfmac4373-sdio.2BC.txt;md5=19b21a45ad1174545fb14992e3aa5dd8 \
                    file://cyfmac4373-sdio.clm_blob;md5=ea7b2ed3706236b5c218ff1f4df7fbc7 \
                    file://BCM4373A0_001.001.025.0103.0156.JRL.2BC.hcd;md5=bbdb081f5e6d75e5ca87ef3b0ccb0bf2 \
                    file://BCM4373A0_001.001.025.0103.0155.FCC.CE.2BC.hcd;md5=1e287a3ab7f83e59352cb321315ea80f \
                    file://cyfmac4373-sdio.bin;md5=c51ffab9a60c5d49db12e09869488162"

# Point to your local firmware files. We will rename them during installation.
SRC_URI = "file://cyfmac4373-sdio.bin \
           file://cyfmac4373-sdio.clm_blob \
           file://BCM4373A0_001.001.025.0103.0156.JRL.2BC.hcd \
           file://BCM4373A0_001.001.025.0103.0155.FCC.CE.2BC.hcd \
           file://cyfmac4373-sdio.2BC.txt"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${nonarch_libdir}/firmware/brcm
    install -d ${D}${nonarch_libdir}/firmware/brcm/murata-master

    # Directly install the firmware files with the names the kernel driver expects.
    # This avoids symbolic links and ensures the files are directly accessible.
    install -m 0444 ${WORKDIR}/cyfmac4373-sdio.bin ${D}${nonarch_libdir}/firmware/brcm/brcmfmac4373-sdio.fsl,imx8mp-evk.bin
    install -m 0444 ${WORKDIR}/cyfmac4373-sdio.2BC.txt ${D}${nonarch_libdir}/firmware/brcm/brcmfmac4373-sdio.txt
    install -m 0444 ${WORKDIR}/cyfmac4373-sdio.clm_blob ${D}${nonarch_libdir}/firmware/brcm/brcmfmac4373-sdio.clm_blob

    # Bluetooth files
    install -m 444 ${WORKDIR}/BCM4373A0_001.001.025.0103.0155.FCC.CE.2BC.hcd ${D}${nonarch_libdir}/firmware/brcm/BCM4373A0.2BC.hcd
    install -m 444 ${WORKDIR}/BCM4373A0_001.001.025.0103.0155.FCC.CE.2BC.hcd ${D}${nonarch_libdir}/firmware/brcm/murata-master/_BCM4373A0.2BC.hcd
}

FILES:${PN} = "${nonarch_libdir}/firmware/brcm/* ${nonarch_libdir}/firmware/brcm/murata-master/*"
