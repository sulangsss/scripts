#!/bin/bash

# install on ubuntu 18.04
sudo apt remove iptables
sudo apt-get update -y
sudo apt-get install -y mosh
# 为了防止出现乱码，安装locales组件
sudo apt-get install -y locales
# 添加对en_US.UTF-8的支持
echo -n "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
echo -n "export LANG=en_US.UTF-8" >> ~/.bashrc
echo -n "export LANGUAGE==en_US.UTF-8" >> ~/.bashrc
# 写入locale配置文件，保存设置
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
# startup mosh-server
cat >> /mosh.sh <<EOF
#!/bin/bash
mosh-server
EOF
chmod +x /mosh.sh
echo "@reboot root /mosh.sh" >> /etc/crontab

# cat >> /etc/systemd/system/mosh.service <<EOF
# [Unit]
# Description=Mosh Service
# After=network.target
# After=systemd-user-sessions.service
# After=network-online.target

# [Service]
# Type=simple
# ExecStart=/mosh.sh
# TimeoutSec=30
# Restart=on-failure
# RestartSec=30
# StartLimitInterval=350
# StartLimitBurst=10

# [Install]
# WantedBy=multi-user.target
# EOF



sudo systemctl enable mosh-server
sudo systemctl start mosh-server

# 修改ssh端口
echo "Port 10000" >> /etc/ssh/sshd_config
sudo systemctl restart sshd