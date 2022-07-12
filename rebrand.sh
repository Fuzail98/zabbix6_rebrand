#!/bin/bash

echo "Rebranding zabbix to activeSONOR!!!"

sudo cp icon-sprite.svg /usr/share/zabbix/assets/img/icon-sprite.svg 
sudo cp blue-theme.css /usr/share/zabbix/assets/styles/blue-theme.css
sudo cp page_header.php /usr/share/zabbix/include/page_header.php 
sudo cp CBrandHelper.php /usr/share/zabbix/include/classes/helpers/CBrandHelper.php
sudo cp general.login.php /usr/share/zabbix/include/views/general.login.php 
sudo cp administration.system.info.php /usr/share/zabbix/app/partials/administration.system.info.php 

convert favicon.png -define icon:auto-resize=256,64,48,32,16 favicon.ico

sudo cp favicon.ico /usr/share/zabbix/favicon.ico

sudo sed -i 's|Alias /zabbix|Alias /activeSONOR|g' /etc/apache2/conf-available/zabbix.conf

sudo systemctl restart zabbix-server.service apache2.service zabbix-agent.service

echo "Rebranding has been done. Kindly refresh and/or clear your browser's cache to see the changes."
echo "When accessing the URL, use <ip>/activeSONOR or <domain>/activeSONOR"
