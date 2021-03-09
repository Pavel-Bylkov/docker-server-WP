FROM debian:buster

# update system components
RUN apt-get update -y && apt-get install -y vim wget \
	mariadb-server nginx php php-fpm php-mbstring php-mysql php-pdo php-gd php-cli php-mbstring php-xml

RUN  rm -rf /var/www/html \
&&	mkdir /var/www/html /var/www/html/wordpress \
# add WordPress
&&	wget -c https://wordpress.org/latest.tar.gz \
&&	tar -xvf latest.tar.gz --strip-components 1 -C /var/www/html/wordpress \
# remove unused more downloaded archives
&&	rm -f latest.tar.gz \
# generate ssl certificate and key
&&	mkdir /etc/nginx/ssl \
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/nginx-selfsigned.crt -keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-subj "/C=RU/ST=Russia/L=Kazan/O=School21/OU=whector/CN=whector-site"

# copy requered sources in container
COPY /srcs/config.inc.php \
	/srcs/nginx.conf \
	/srcs/wp-config.php \
	/srcs/launch.sh \
	/srcs/autoindex.sh ./

# move config-files
RUN mv /nginx.conf /etc/nginx/sites-available/site \
&&	mv /wp-config.php /var/www/html/wordpress \
# enable nginx site configuration
&&	ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/ \
# remove unused nginx default configuration
&&	rm -f /etc/nginx/sites-enabled/default \
# let web services be owner of site's root directory (to have access to it's files)
&&	chown -R www-data:www-data /var/www/html \
# change directory permissions rwxr-xr-x
&&	find /var/www/html/ -type d -exec chmod 755 {} \; \
# change files permissions rw-r--r--
&&	find /var/www/html/ -type f -exec chmod 644 {} \; \
# make scripts executable
&&	chmod +x launch.sh autoindex.sh

# set ports on which a container listens for connections
EXPOSE 80 443

# launch server
CMD bash launch.sh
