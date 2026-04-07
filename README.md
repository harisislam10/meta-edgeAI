 => Installing the "Repo" Tool:
NXP uses the repo tool from google to manage the git layers involved in i.MX yocto build system. 
This repo is used to download manifests for i.MX BSP releases.

To initialize repo tool: 


mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=${PATH}:~/bin
# Add to your bashrc so it's permanent
echo 'export PATH=${PATH}:~/bin' >> ~/.bashrc


=> After installing the repo in your host pc: 
Create a folder and fetch the NXP manifest. 

#creating your workspace
mkdir your_workspace
cd your_workspace

#initializing the repo for Scarthgap (Stable)
repo init -u https://github.com/nxp-imx/imx-manifest.git -b imx-linux-scarthgap -m imx-6.6.36-2.1.0.xml

# Download the layers
repo sync


#This will download all necessary layers: for example meta-openembedded, poky, and all essential layers for NXP

#download the meta-falcon layer: 
go to source folder and clone the repository: git clone https://github.com/harisislam10/meta-falcon.git

#initialize the build environment: 
from your project workspace directory: source sources/poky/oe-init-build-env <your targeted build folder path> 

# add the necessary layers with the meta-falcon layer
use bitbake-layers add-layer command or you can directly edit the layers from /build/conf/bblayers.conf file. 

#Add machine specific configurations from local.conf

set machine name: falcon-s1/ falcon-s1-lite, falcon-s1-hailo.
for example: 
MACHINE ??= "falcon-s1" 
