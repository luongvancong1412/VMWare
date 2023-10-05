#!/bin/bash

#neu khong root thi stop
if [ `id -u` -ne 0 ]; then
	echo Need sudo
	exit 1
fi

set -v
#xoa user
userdel sun

# update bao mat va cac package moi nhat
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt autoremove -y

# basic OS packages
sudo apt install jq vim git dos2unix zip unzip curl wget dnsutils traceroute swaks open-vm-tools -y

# install VMware agent package
sudo apt install -y open-vm-tools
vmware-toolbox-cmd config set deployPkg enable-custom-scripts true

# cleanup
sudo apt autoremove -y
sudo apt clean

# disable IPv6
#echo net.ipv6.conf.all.disable_ipv6=1 | sudo tee -a /etc/sysctl.conf
#echo net.ipv6.conf.default.disable_ipv6=1 | sudo tee -a /etc/sysctl.conf
#echo net.ipv6.conf.lo.disable_ipv6=1 | sudo tee -a /etc/sysctl.conf
#sudo sysctl -p

# Stop services for cleanup
sudo service rsyslog stop

#clear audit logs
if [ -f /var/log/wtmp ]; then
    sudo truncate -s0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    sudo truncate -s0 /var/log/lastlog
fi

# cleanup /tmp directories
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# cleanup current ssh keys
sudo rm -f /etc/ssh/ssh_host_*

# add check for ssh keys on reboot...regenerate if neccessary
cat << 'EOL' | sudo tee /etc/rc.local
#!/bin/sh
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server

id | grep root 1>/dev/null 2>&1
if test 0 = 0; then
   growpart /dev/sda 3 > /dev/null 2>&1
   pvresize /dev/sda3 > /dev/null 2>&1
   lvextend -l +100%FREE -r /dev/mapper/ubuntu--vg-ubuntu--lv > resize.txt 2>&1; cat resize.txt | grep GiB
else
  echo
fi
EOL

# make sure the script is executable
sudo chmod +x /etc/rc.local
cat << 'EOL' | sudo tee /etc/systemd/system/rc-local.service
[Unit]
 Description=/etc/rc.local Compatibility
 ConditionPathExists=/etc/rc.local

[Service]
 Type=forking
 ExecStart=/etc/rc.local start
 TimeoutSec=0
 StandardOutput=tty
 RemainAfterExit=yes
 SysVStartPriority=99

[Install]
 WantedBy=multi-user.target
EOL
systemctl start rc-local.service
systemctl enable rc-local

# reset hostname
# prevent cloudconfig from preserving the original hostname
sudo sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
sudo truncate -s0 /etc/hostname
sudo hostnamectl set-hostname localhost

cat << 'EOL' | sudo tee /etc/motd
 ____                   _                 _ 
/ ___| _   _ _ __   ___| | ___  _   _  __| |
\___ \| | | | '_ \ / __| |/ _ \| | | |/ _` |
 ___) | |_| | | | | (__| | (_) | |_| | (_| |
|____/ \__,_|_| |_|\___|_|\___/ \__,_|\__,_|
                                            
********************************************
Website: https://suncloud.vn/
********************************************
EOL

# disable swap
sudo swapoff --all
sudo sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

# make machine-id unique and symlink it - ubuntu 20.04 uses machine id in the dhcp identifier and not mac addresses
sudo truncate -s 0 /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

# set dhcp to use mac - this is a little bit of a hack but I need this to be placed under the active nic settings
# also look in /etc/netplan for other config files
#sudo sed -i 's/optional: true/dhcp-identifier: mac/g' /etc/netplan/50-cloud-init.yaml

# cleans out all of the cloud-init cache / logs - this is mainly cleaning out networking info
sudo cloud-init clean --logs

# cleanup shell history
cat /dev/null > ~/.bash_history && history -c