# Shared override for Falcon-S1 family

MACHINEOVERRIDES =. "mx8mp:imx8mp-lpddr4-evk:falcon-s1-common:"

# Hardware Capabilities
MACHINE_FEATURES += "wifi bluetooth pci devicetree"

# Inherit NXP's i.MX8MP building blocks
require conf/machine/include/imx-base.inc
require conf/machine/include/arm/armv8a/tune-cortexa53.inc

# Bootloader (U-Boot) Hardware Constants
UBOOT_CONFIG ??= "sd"
UBOOT_SUFFIX = "bin"
SPL_BINARY = "spl/u-boot-spl.bin"
ATF_PLATFORM = "imx8mp"
IMXBOOT_TARGETS = "flash_evk"
IMX_BOOT_SOC_TARGET = "iMX8MP"

# LPDDR4 Firmware:  8GB LPDDR4 
DDR_FIRMWARE_NAME = " \
    lpddr4_pmu_train_1d_dmem_202006.bin \
    lpddr4_pmu_train_1d_imem_202006.bin \
    lpddr4_pmu_train_2d_dmem_202006.bin \
    lpddr4_pmu_train_2d_imem_202006.bin \
"

# wifi Hardware Support
MACHINE_EXTRA_RRECOMMENDS += " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'wifi', 'murata-firmware wifi-autoconnect', '', d)} \
    kernel-module-imx-sdma \
"

#  Serial Console on UART2
SERIAL_CONSOLES = "115200;ttymxc1"

#  System Management 
DISTRO_FEATURES:append = " systemd"
VIRTUAL-RUNTIME_init_manager = "systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED:append = " sysvinit"
VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"

# Image Creation (Custom Falcon-S1)
WKS_FILE = "falcon-s1-lite.wks"
IMX_BOOT_SEEK = "32"

# Tell WIC that "imx-boot" in the .wks file refers to the actual boot binary
IMAGE_BOOTLOADER = "imx-boot"

# Ensure dependencies are met
do_image_wic[depends] += "imx-boot:do_deploy"
WICVARS:append = " IMX_BOOT_SEEK"

# Output Formats
IMAGE_FSTYPES = "wic.zst tar.gz ext4"
