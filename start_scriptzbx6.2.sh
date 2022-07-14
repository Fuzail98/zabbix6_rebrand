#!/bin/bash
apt update
wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu20.04_all.deb
dpkg -i zabbix-release_6.2-1+ubuntu20.04_all.deb
apt update
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
apt install -y mysql-server
mysql -u root -e"create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -u root -e"create user zabbix@localhost identified by 'password';"
mysql -u root -e"grant all privileges on zabbix.* to zabbix@localhost;"
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uroot zabbix
sed -i 's/# DBPassword=/DBPassword=password/g' /etc/zabbix/zabbix_server.conf
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
apt install git -y
git clone https://github.com/Fuzail98/zabbix6_rebrand.git
cd zabbix6_rebrand
cp icon-sprite.svg /usr/share/zabbix/assets/img/icon-sprite.svg 
cp blue-theme.css /usr/share/zabbix/assets/styles/blue-theme.css
cp CBrandHelper.php /usr/share/zabbix/include/classes/helpers/CBrandHelper.php
cp page_header.php /usr/share/zabbix/include/page_header.php 
cp general.login.php /usr/share/zabbix/include/views/general.login.php 
cp administration.system.info.php /usr/share/zabbix/app/partials/administration.system.info.php 
cp brand.conf.php /usr/share/zabbix/local/conf/brand.conf.php
cp favicon.ico /usr/share/zabbix/favicon.ico
sed -i 's|Alias /zabbix|Alias /activeSONOR|g' /etc/apache2/conf-available/zabbix.conf
systemctl restart zabbix-server.service apache2.service zabbix-agent.service
