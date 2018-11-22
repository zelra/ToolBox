#!/bin/bash

iw dev wlan0 scan > /tmp/tmp.txt

home=$(cat /tmp/tmp.txt |grep "SSID: MaBox1")
phone=$(cat /tmp/tmp.txt |grep "SSID: MaBox2")

if [[ ! -z "$home" ]]
then
	sed -i "s/ssid.*/ssid=\"MaBox1\"/" /etc/wpa_supplicant/wpa_supplicant.conf
	sed -i "s/psk.*/psk=\"MonMotDePasse1\"/" /etc/wpa_supplicant/wpa_supplicant.conf
	sed -i "s/^static ip_address.*/static ip_address=MonIP1\/24/" /etc/dhcpcd.conf
	sed -i "s/^static routers.*/static routers=MonRouteur1/" /etc/dhcpcd.conf
	sed -i "s/^static domain_name_servers.*/static domain_name_servers=MonRouteur1 8.8.8.8/" /etc/dhcpcd.conf

	echo "Il y a le wifi de la maison"

elif [[ ! -z "$phone" ]]
then
	sed -i "s/ssid.*/ssid=\"MaBox2\"/" /etc/wpa_supplicant/wpa_supplicant.conf
	sed -i "s/psk.*/psk=\"MonMotDePasse2\"/" /etc/wpa_supplicant/wpa_supplicant.conf
	sed -i "s/^static ip_address.*/static ip_address=MonIP2\/24/" /etc/dhcpcd.conf
	sed -i "s/^static routers.*/static routers=MonRouteur2/" /etc/dhcpcd.conf
	sed -i "s/^static domain_name_servers.*/static domain_name_servers=MonRouteur2 8.8.8.8/" /etc/dhcpcd.conf

	echo "Il y a le wifi de mon tel"

else
	echo "J'ai rien trouvé"
fi
rm /tmp/tmp.txt
