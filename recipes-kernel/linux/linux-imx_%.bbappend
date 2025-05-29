FILESEXTRAPATHS:prepend := "${THISDIR}/linux-imx:"
SRC_URI += "file://0001-Kernal-device-tree-modification.patch \
            file://0001-Change-Codec-node-form-i2c3-to-i2c2.patch \
            file://0001-add-i2c2-node-to-imx8mp-evk-rpmsg.dts.patch \
            file://0001-Adding-8-bit-Pcal6408a-GPIO-Expender.patch \
            file://0001-Adding-pinctrl-for-pcal6408.patch \
            file://0001-Enabling-wifi-and-bluetooth-in-dts.patch \
            file://0001-Removing-conflict-MX8MP_IOMUXC_GPIO1_IO04.patch \
            file://0001-Disable-vmmc-from-usdhc2.patch \
            file://0001-Change-usdhc-frequency-to-25MHZ.patch \
            file://0001-toggle-pcal6408-high.patch \
            file://0001-Update-gpio-hog.patch \
            file://gpio_fragment.cfg \
            file://pcal6408.cfg"


#KERNEL_CONFIG_FRAGMENTS += "gpio_fragment.cfg pcal6408.cfg"

do_configure:append() {
    cd ${B}
    
    # Start clean and copy default defconfig
    oe_runmake mrproper
    cp ${WORKDIR}/defconfig .config || touch .config

    # Merge all your fragments using kernel's merge_config.sh
    echo "Merging kernel config fragments..."
    ${S}/scripts/kconfig/merge_config.sh -m -r -O ${B} .config \
        ${WORKDIR}/gpio_fragment.cfg \
        ${WORKDIR}/pcal6408.cfg

    # Finalize the config
    yes "" | oe_runmake olddefconfig
}
