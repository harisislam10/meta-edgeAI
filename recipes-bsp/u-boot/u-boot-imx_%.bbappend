FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-imx:"
SRC_URI += "file://0001-Modified-Uboot.patch \
            file://0001-Update-memory-node-from-6gb-to-8gb.patch \
            file://0001-Change-Header-file.patch \
            file://lpddr4_timing.c "


do_compile:prepend() {
    cp ${WORKDIR}/lpddr4_timing.c ${S}/board/freescale/imx8mp_evk/lpddr4_timing.c
}
