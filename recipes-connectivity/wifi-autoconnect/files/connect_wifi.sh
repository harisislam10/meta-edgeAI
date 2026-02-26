#!/bin/sh

SSID="QuestAdaptations_2.4GHz"
PASSWORD="Quest0124556044"
IFACE="wlan0"
GATEWAY="192.168.0.1"
DNS="8.8.8.8"

echo "==> Bringing up interface $IFACE..."
ip link set $IFACE up

echo "==> Writing wpa_supplicant config..."
cat > /etc/wpa_supplicant.conf << EOF
ctrl_interface=/var/run/wpa_supplicant
update_config=1

network={
    ssid="$SSID"
    psk="$PASSWORD"
    key_mgmt=WPA-PSK
}
EOF

echo "==> Killing any existing wpa_supplicant instances..."
killall wpa_supplicant 2>/dev/null
sleep 1

echo "==> Starting wpa_supplicant..."
wpa_supplicant -B -i $IFACE -c /etc/wpa_supplicant.conf -D nl80211,wext

echo "==> Waiting for association..."
sleep 5

echo "==> Requesting IP via DHCP..."
if command -v udhcpc > /dev/null 2>&1; then
    udhcpc -i $IFACE -t 10 -n
elif command -v dhclient > /dev/null 2>&1; then
    dhclient $IFACE
else
    echo "ERROR: No DHCP client found!"
    exit 1
fi

echo "==> Setting default gateway..."
ip route del default 2>/dev/null
ip route add default via $GATEWAY dev $IFACE

echo "==> Setting DNS..."
echo "nameserver $DNS" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo "==> Verifying connection..."
ip addr show $IFACE
echo ""
echo "==> Routes:"
ip route show
echo ""
ping -c 3 8.8.8.8 && echo "==> WiFi connected successfully!" || echo "==> Ping failed, check connection."
