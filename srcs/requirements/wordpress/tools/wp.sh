#!/bin/bash

FILE=/var/www/wordpress/wp-config.php
#sleeping to let mariadb launch before installing/running wp
sleep 20

if [ -f "$FILE" ]; then
	echo "Wordpress Already Set-Up!"
else
	echo "Wordpress Not Set-Up yet"
	
	echo "Creating Wordpress Config..."
	wp config create --dbname=${MARIADB_DATABASE}\
			 --dbuser=${WP_ADMIN_USER}\
			 --dbpass=${WP_ADMIN_PWD}\
			 --dbhost=${MARIADB_HOST}:${MARIADB_PORT}\
			 --dbcharset="utf8mb4"\
			 --dbcollate=''\
			 --allow-root;
	echo "Installing WordpressCore..."
	echo "Setting-Up Admin, Title, URL..."
	wp core install --url=lboulang.42.fr \
	                --title=${WP_TITLE} \
        	        --admin_user=${WP_ADMIN_USER} \
			--admin_password=${WP_ADMIN_PWD} \
                   	--admin_email=${WP_EMAIL}\
			--allow-root
	echo "Creating Author User..."
	wp user create ${AUTHOR_NAME} ${AUTHOR_EMAIL} \
			--user_pass=${AUTHOR_PASS} \
        		--role=author\
			--allow-root;
	echo "Wordpress Set-Up Done!"
fi 

echo "Launching php-fpm, Wordpress is UP"
exec php-fpm7.4 -F
