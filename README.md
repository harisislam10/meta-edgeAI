# **`edgeAI-v1`** 

## Overview

The **`edgeAI-v1`** branch of the `meta-edgeAI` layer provides **Yocto BSP support for the Elliance Falcons1 platform** based on the **NXP i.MX 8M Plus (i.MX8MP)** SoC.

This branch targets a **headless or lightweight graphical environment**, optimized for **AI edge applications**, system stability, and low resource usage. It uses the **Weston compositor** as the primary display manager, configured via a custom `weston.ini` file to enable flexible runtime display management without a full desktop stack.

---

## Hardware Platform

| **Item**              | **Description**                                           |
|------------------------|-----------------------------------------------------------|
| **Board Name**         | Falcons1                                                  |
| **Processor**          | NXP i.MX 8M Plus Quad (i.MX8MP)                           |
| **RAM**                | 8 GB LPDDR4                                               |
| **Storage**            | eMMC / SD                                                 |
| **Connectivity**       | Ethernet + Wi-Fi (boot enabled)                           |
| **USB**                | Type-C with PD, USB 3.0 Hub (USB5807C)                    |
| **Display Interface**  | MIPI-DSI / HDMI                                           |
| **OS Base**            | Yocto Linux (Wayland/Weston based)                        |

---

## Layer Features

The `meta-edgeAI` layer (branch `edgeAI-v1`) integrates the following features:

###  Device Tree & BSP Modifications

- Custom DTS: `imx8mp-falcons1.dts`
- Enabled peripherals:
  - USB5807C 7-port USB 3.0 hub
  - HD3SS3220 Type-C DRP controller (I2C)
  - Wi-Fi and Bluetooth modules enabled at boot
  - GPIO and I2C pinmux alignment for Falcons1 hardware
- Updated LPDDR4 timing configuration for **8GB RAM support**

###  Weston Display Configuration

- Weston compositor enabled with **Wayland backend**
- Custom `weston.ini` to:
  - Set display resolution and refresh rate
  - Auto-launch applications at boot (if configured)
  - Define output scaling and position
- Supports:
  - HDMI and MIPI-DSI display outputs
  - Touchscreen integration via input subsystem

Example `weston.ini` snippet:

```ini
[core]
idle-time=0
require-input=false

[output]
name=HDMI-A-1
mode=1920x1080
transform=normal

[shell]
panel-position=none
locking=false
```

###  Networking

- Ethernet autoconfigured with DHCP
- Wi-Fi auto-enabled via systemd service
- Compatible with connman or NetworkManager

###  USB and Power Delivery

- Integrated Type-C PD control via HD3SS3220 driver
- USB role-switching supported for DRP mode
- Fully functional USB 3.0 ports through USB5807C hub

###  Memory Configuration

- 8GB LPDDR4 supported
- Includes updated `lpddr_timing.c` via BSP append

---

##  Build Instructions

Ensure you have a working NXP Yocto BSP setup (e.g., imx-linux-hardknott or later).

### 1. Clone the BSP and Layers

```bash
mkdir -p ~/BSPs/nxp/edgeAI/sources
cd ~/BSPs/nxp/edgeAI/sources

# Clone the main BSP and this layer
git clone https://github.com/nxp-imx/meta-imx.git -b imx-linux-hardknott
git clone https://github.com/<your-username>/meta-edgeAI.git -b edgeAI-v1
```

### 2. Initialize the Build Environment

```bash
cd ~/BSPs/nxp/edgeAI
source setup-environment build
```

### 3. Add the Custom Layer

In your `bblayers.conf`, append:

```
${BSPDIR}/sources/meta-edgeAI \
```

### 4. Build the Image

```bash
bitbake imx-image-multimedia
```

Or:

```bash
bitbake imx-image-full
```

---

##  Notes

The `edgeAI-v1` branch is optimized for embedded edge workloads with minimal GUI dependencies.

**Ideal for headless use cases such as:**

- AI inferencing via NPU
- Camera and sensor-based processing
- Industrial IoT gateways

Weston is only used for minimal display management, not for a full desktop session.
