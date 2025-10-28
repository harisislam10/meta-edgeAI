FILESEXTRAPATHS:prepend := "${THISDIR}/linux-imx:"
SRC_URI += "file://0001-Changing-dts-according-edgeAIboard.patch \
            file://0001-Kernal-device-tree-modification.patch \
            file://0001-adding-semicoln.patch \
            file://0001-update-IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK1.patch \
            file://0001-add-i2c2-node-to-imx8mp-evk-rpmsg.dts.patch \
            file://0001-update-pinctrl_pcal6408_int.patch \
            file://0001-changing-IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK1.patch \
            file://0001-Change-Ethernet-reset-pins.patch \
            file://gpio_fragment.cfg \
            file://pcal6408.cfg \
            file://0001-Adding-Hailo-config-to-dts.patch \
            file://0001-Hailo-issue-part2-pin-duplication.patch \
            file://0001-pcie-modify-3.patch \
            file://0001-pcie-modify-4.patch \
            file://0001-pcie-modify-5.patch \
            file://0001-Adding-wifi-to-usdhc1.patch \
            file://0001-removing-comment-section-from-usdhc2-wifi.patch \  
            file://0001-usdhc1-fixation-3.patch \  
            file://0001-Adding-Internel-GPIO-Expander.patch \   
            file://0001-Removing-extra-bracket-in-internel-gpio-expender.patch \
            file://0001-Removing-interupts-for-PCA-internel-GPIO-expender.patch \        
            file://0001-Removing-bracket-in-internel-gpio-expander.patch \
            file://0001-Porting-CSI-Camera-to-Falon_SBC.patch \
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_2.patch \
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_3.patch \      
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_4.patch \     
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_5.patch \   
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_6.patch \
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_7.patch \ 
            file://0001-Porting-CSI-Camera-to-Falcon_SBC_8.patch \   
            file://0001-Removig-Chip-id-from-c-file.patch \
            file://0001-Adding-nau8822-sound-dts.patch \ 
            file://0001-Adding-nau8822-sound-dts_2.patch \
            file://0001-Adding-nau8822-sound-dts_3.patch \
            file://0001-Adding-nau8822-sound-dts_4.patch \
            file://0001-Adding-Uart4-node.patch \
            file://0001-Adding-Uart4-node-2.patch \
            file://nau8822.cfg \                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
            file://docker.cfg"


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
        ${WORKDIR}/docker.cfg \
        ${WORKDIR}/nau8822.cfg \
        ${WORKDIR}/pcal6408.cfg 
        

    # Finalize the config
    yes "" | oe_runmake olddefconfig
}

do_configure:append() {
    
    yes "" | oe_runmake oldconfig
}
