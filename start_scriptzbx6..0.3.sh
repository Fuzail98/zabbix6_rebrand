#!/bin/bash
sudo apt update
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-3+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-3+ubuntu20.04_all.deb
sudo apt update
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
sudo apt install -y mysql-server
sudo mysql -u root -e"create database zabbix character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -u root -e"create user zabbix@localhost identified by 'password';"
sudo mysql -u root -e"grant all privileges on zabbix.* to zabbix@localhost;"
sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uroot zabbix
sudo sed -i 's/# DBPassword=/DBPassword=password/g' /etc/zabbix/zabbix_server.conf
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
sudo cp icon-sprite.svg /usr/share/zabbix/assets/img/icon-sprite.svg 
sudo cp blue-theme.css /usr/share/zabbix/assets/styles/blue-theme.css
sudo cp CBrandHelper.php /usr/share/zabbix/include/classes/helpers/CBrandHelper.php
sudo cp page_header.php /usr/share/zabbix/include/page_header.php 
sudo cp general.login.php /usr/share/zabbix/include/views/general.login.php 
sudo cp administration.system.info.php /usr/share/zabbix/app/partials/administration.system.info.php 
sudo cp brand.conf.php /usr/share/zabbix/local/conf/brand.conf.php
sudo cp favicon.ico /usr/share/zabbix/favicon.ico
sudo sed -i 's|Alias /zabbix|Alias /activeSONOR|g' /etc/apache2/conf-available/zabbix.conf
sudo systemctl restart zabbix-server.service apache2.service zabbix-agent.service
