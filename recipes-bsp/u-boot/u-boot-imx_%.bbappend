FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-imx:"
DEPENDS += "virtual/libc gcc-cross-${TARGET_ARCH}"

SRC_URI += "file://0001-Modified-Uboot.patch \
            file://0001-Update-memory-node-from-6gb-to-8gb.patch \
            file://0001-Change-Header-file.patch \
            file://lpddr4_timing.c "


do_compile:prepend() {
    cp ${WORKDIR}/lpddr4_timing.c ${S}/board/freescale/imx8mp_evk/lpddr4_timing.c
    echo 'CONFIG_EXTRA_ENV_SETTINGS="bootargs_default=console=ttymxc1,115200 root=/dev/mmcblk2p2 rootwait rw splash plymouth.ignore-serial-consoles quiet loglevel=3 vt.global_cursor_default=0 plymouth.enable=1 plymouth.delay=15000"' >> ${B}/.config
    # Update defconfig
    oe_runmake -C ${S} O=${B} olddefconfig
}

