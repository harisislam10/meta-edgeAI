FILESEXTRAPATHS:prepend := "${THISDIR}/linux-imx:"
SRC_URI += "file://0001-Changing-dts-according-edgeAIboard.patch \
            file://0001-Kernal-device-tree-modification.patch \
            file://0001-adding-semicoln.patch \
            file://0001-update-IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK1.patch \
            file://0001-add-i2c2-node-to-imx8mp-evk-rpmsg.dts.patch \
            file://0001-update-pinctrl_pcal6408_int.patch \
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
