FILESEXTRAPATHS:prepend := "${THISDIR}/linux-imx:"
SRC_URI += "file://0001-Falcon-S1-dts-for-edgeAI-v1.patch \
            file://0001-Falcon-S1-dts-for-edgeAI-v1-2.patch \
            file://0001-Falcon-S1-dts-for-edgeAI-v1-3.patch \
            file://0001-Falcon-S1-dts-for-edgeAI-v1-4.patch \
            file://0001-Falcon-S1-dts-for-edgeAI-v1-5.patch \
            file://0001-Falcon-S1-dts-for-edgeAI-v1-6.patch \
            file://0001-Falcon-S1-dts-for-edgeAI-v1-7.patch \
            file://gpio_fragment.cfg \
            file://docker.cfg \
            file://nologo.cfg \
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
        ${WORKDIR}/pcal6408.cfg \
        ${WORKDIR}/docker.cfg \
        ${WORKDIR}/nologo.cfg
        
    
    # Finalize the config
    yes "" | oe_runmake olddefconfig
}




do_configure:append() {
    
    yes "" | oe_runmake oldconfig
}

