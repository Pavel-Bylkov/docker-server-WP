#!/bin/bash

wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz
tar -zxvf phpMyAdmin-latest-english.tar.gz
mv phpMyAdmin-5.1.0-english phpmyadmin
mv phpmyadmin /var/www/html
rm phpMyAdmin-latest-english.tar.gz
mkdir /var/www/html/phpmyadmin/tmp
chmod 755 config.inc.php
mv config.inc.php /var/www/html/phpmyadmin


service php7.3-fpm start
service nginx start

name_db='site_db'
user_db='admin'
password_db='1234'
service mysql restart
mysql -e "CREATE DATABASE $name_db;"
mysql -e "CREATE USER '$user_db'@'localhost' IDENTIFIED BY '$password_db';"
mysql -e "GRANT ALL PRIVILEGES ON $name_db.* TO '$user_db'@'localhost' IDENTIFIED BY '$password_db';"
mysql -e "FLUSH PRIVILEGES;"


service php7.3-fpm restart 
service nginx restart
bash