
#!/bin/sh
echo "[wifi-autoconnect] Bringing up wlan0..."
ifconfig wlan0 up
sleep 1

echo "[wifi-autoconnect] Setting DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf

echo "[wifi-autoconnect] Starting wpa_supplicant..."
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf

sleep 3
echo "[wifi-autoconnect] Starting DHCP..."
udhcpc -i wlan0 -x hostname:imx8mpevk
