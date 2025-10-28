# meta-edgeAI (edgeAIdesktop-v1)

##  Overview

This branch — **`edgeAIdesktop-v1`** — provides the **Yocto meta-layer support for the Elliance Falcons1 desktop configuration**, based on the **NXP i.MX 8M Plus (i.MX8MP)** processor.  
It is designed to build and run an **Ubuntu-based graphical Linux image** optimized for the **Falcons1 custom hardware** platform.

This branch focuses on:
- Enabling a **desktop-class environment** (X11/Wayland-based)
- Configuring **Wi-Fi**, **Ethernet**, and **USB peripherals**
- Applying **custom device tree modifications** for the Falcons1 hardware
- Ensuring smooth integration of Ubuntu packages and BSP drivers

---
##  Hardware Platform
| **Item**                | **Description**                                           |
|-------------------------|-----------------------------------------------------------|
| **Board Name**          | Falcons1                                                  |
| **Processor**           | NXP i.MX 8M Plus Quad (i.MX8MP)                           |
| **RAM**                 | 8 GB LPDDR4                                               |
| **Storage**             | eMMC / SD                                                 |
| **Connectivity**        | Wi-Fi + Bluetooth (enabled on boot)                       |
| **USB**                 | Type-C with PD, USB 3.0 Hub (USB5807C)                    |
| **Display Interface**   | MIPI-DSI / HDMI                                           |
| **OS Base**             | Ubuntu-based desktop image                                |

---

##  Layer Features

The `meta-edgeAI` layer (branch `edgeAIdesktop-v1`) provides:

###  Device Tree Customization
- Custom DTS: `imx8mp-falcons1-desktop.dts`
- Peripheral enablement:
  - Wi-Fi/BT module enabled at boot
  - USB5807C 7-port hub configuration
  - HD3SS3220 Type-C DRP port controller
  - Custom GPIO and I2C bus assignments
  - Display and camera pin mux configuration

###  Ubuntu Image Integration
- Adds support for **Ubuntu-based root filesystem**
- Preconfigures **GNOME desktop environment**
- Enables **XWayland** compatibility for graphical applications
- Auto-starts **NetworkManager** and desktop session on boot

###  Networking
- Wi-Fi enabled automatically at boot via systemd service
- Ethernet autoconfigured with DHCP
- Supports `connman` or `NetworkManager` depending on build setup

###  USB and Power Delivery
- Integrated USB Type-C controller (HD3SS3220) via I2C
- Configurable role switching (DRP)
- Compatible with standard USB PD sink/source devices

###  Memory Configuration
- Supports **8GB LPDDR4 RAM** initialization
- Custom LPDDR4 timing parameters via `lpddr_timing.c` integration

---

##  Build Instructions

> Ensure your Yocto setup already includes NXP’s BSP for i.MX8MP (e.g., `imx-linux-hardknott` or later).

### 1. Clone BSP and layers

```bash
mkdir -p ~/BSPs/nxp/imxdesktop/sources
cd ~/BSPs/nxp/imxdesktop/sources

# Clone your custom layer
git clone -b edgeAIdesktop-v1 https://github.com/<your-username>/meta-edgeAI.git
