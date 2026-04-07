FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Add ALL files from linux-imx  to the build fetcher
SRC_URI += " \
    file://falcon-common.dtsi \
    file://falcon-s1.dts \
    file://falcon-s1-lite.dts \
    file://falcon-s1-hailo.dts \
    file://pcal6408.cfg \
    file://docker.cfg \
    file://nologo.cfg \
    file://gpio_fragment.cfg \
"

# Copy the files into the Kernel Source 

do_configure:prepend() {
    cp ${WORKDIR}/falcon-common.dtsi ${S}/arch/arm64/boot/dts/freescale/
    cp ${WORKDIR}/falcon-s1.dts      ${S}/arch/arm64/boot/dts/freescale/
    cp ${WORKDIR}/falcon-s1-lite.dts ${S}/arch/arm64/boot/dts/freescale/
    cp ${WORKDIR}/falcon-s1-hailo.dts ${S}/arch/arm64/boot/dts/freescale/
}

# Register the output targets

KERNEL_DEVICETREE:append = " \
    freescale/falcon-s1.dtb \
    freescale/falcon-s1-lite.dtb \
    freescale/falcon-s1-hailo.dtb \
"