#!/bin/bash

echo "Rebranding zabbix to activeSONOR!!!"

sudo cp icon-sprite.svg /usr/share/zabbix/assets/img/icon-sprite.svg 
sudo cp favicon.ico /usr/share/zabbix/favicon.ico
sudo cp blue-theme.css /usr/share/zabbix/assets/styles/blue-theme.css
sudo cp page_header.php /usr/share/zabbix/include/page_header.php 
sudo cp CBrandHelper.php /usr/share/zabbix/include/classes/helpers/CBrandHelper.php
sudo cp general.login.php /usr/share/zabbix/include/views/general.login.php 
sudo cp administration.system.info.php /usr/share/zabbix/app/partials/administration.system.info.php 

echo "Rebranding has been done. Kindly refresh and/or clear your browser's cache to see the changes."
