# meta-edgeAI

**meta-edgeAI** is a custom Yocto layer repository designed for the **Elliance Falcons1** custom hardware platform, which is based on the **NXP i.MX 8M Plus (i.MX8MP)** processor.  
This repository contains multiple branches, each targeting different BSP and image configurations tailored for specific use cases.

---

##  Overview

The `meta-edgeAI` layer extends the NXP i.MX Yocto BSP to support **Elliance Falcons1** hardware variations.  
It provides customization for both **headless EdgeAI** and **Ubuntu desktop-based** builds, enabling a flexible environment for AI acceleration, multimedia, and embedded Linux applications.

---

##  Available Branches

| Branch Name | Description |
|--------------|-------------|
| **edgeAIdesktop-v1** | Designed for the **Falcons1 i.MX8MP Desktop** platform. Runs an **Ubuntu-based graphical image** for desktop and development purposes. Includes custom DTS modifications, Wi-Fi enablement at boot, and peripheral configurations. |
| **edgeAI-v1** | Designed for the **Falcons1 EdgeAI** variant focused on **headless operation**, AI/ML workloads, and optimized performance for inference engines and edge deployments. |
| **main** | Documentation and repository overview (you’re here). |

---

##  Layer Purpose

The `meta-edgeAI` layer provides:
- Custom **device tree support** for Elliance Falcons1 hardware  
- **Machine configuration** for 8GB LPDDR4 RAM  
- **Wi-Fi enablement at bootup** and peripheral initialization  
- **USB PD & Type-C controller integration**  
- **bbappend** overrides for camera, display, and multimedia packages  
- Integration with Ubuntu Desktop rootfs for GUI builds  

---

##  Getting Started

Clone this repository and switch to the desired branch for your build:

```bash
git clone https://github.com/<your-username>/meta-edgeAI.git
cd meta-edgeAI
git checkout edgeAIdesktop-v1

```

```bash
git clone https://github.com/<your-username>/meta-edgeAI.git
cd meta-edgeAI
git checkout edgeAI-v1
```

## Then, add it to your Yocto build environment:
```bash
bitbake-layers add-layer ../sources/meta-edgeAI
```

## Supported Platforms

 - Elliance Falcons1 Custom Board (i.MX8MP, 8GB RAM)
 - NXP i.MX 8M Plus Evaluation Kit (for reference development)

## 👤 Maintainer

**Haris Islam**  
*Embedded System Software Engineer – EdgeAI & Linux BSP Development*  
  
**Email:**     [islamharis87@gmail.com](mailto:islamharis87@gmail.com)  
**LinkedIn:**  [linkedin.com/in/harisislam10](https://www.linkedin.com/in/harisislam10)

 
