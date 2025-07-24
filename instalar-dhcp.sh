#!/bin/bash

echo "Instalando DHCP Server"
apt update && apt install isc-dhcp-server -y

echo "Configurando DHCP..."
cat > /etc/dhcp/dhcpd.conf <<EOF
default-lease-time 600;
max-lease-time 7200;
subnet 172.23.23.0 netmask 255.255.255.0 {
  range 172.23.23.50 172.23.23.200;
  option routers 172.23.23.1;
  option domain-name-servers 8.8.8.8;
}
EOF

echo "Asignando interfaz al DHCP..."
sed -i 's/INTERFACESv4=""/INTERFACESv4="enp0s8"/' /etc/default/isc-dhcp-server

systemctl restart isc-dhcp-server
systemctl enable isc-dhcp-server
