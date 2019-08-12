#!/bin/sh
# Check if root
if [ "$(whoami)" != "root" ]; then
  whiptail --msgbox "This script must be run by the root user." $WT_HEIGHT $WT_WIDTH
  exit
fi

# Check if raspi-config is installed
if [ $(dpkg-query -W -f='${Status}' raspi-config 2>/dev/null | grep -c "installed") -eq 1 ]; then
  whiptail --msgbox "raspi-config is already installed, this script does not upgrade..." 10 60
else
  wget https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20190709_all.deb -P /tmp
  apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
  # Auto install dependancies on eg. ubuntu server on RPI
  apt-get install -fy
  dpkg -i /tmp/raspi-config_20190709_all.deb
  whiptail --msgbox "raspi-config is now installed. Run by typing: sudo raspi-config" 10 60
fi

exit
