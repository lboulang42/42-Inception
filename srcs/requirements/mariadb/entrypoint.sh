#!/bin/sh

if [ ! -d /var/lib/mysql/mysql ]; then #check if database is not already created
	echo "\nDatabase is not created yet\n"
	mysql_install_db --datadir=$DATADIR   > /dev/null
	echo "\n myslq_install_db done\n"

	echo "\nLaunch with mysqld_safe\n"
	mysqld_safe &

	sleep 2

	echo "\nGoing to :\n"
	echo "Delete default databases from msql\n"
	echo "Set password for root user\n"
	echo "Create db $MARIADB_DATABASE\n"
	echo "Create user $WP_ADMIN_USER with $WP_ADMIN_PWD\n"
	echo " Give all privileges to $WP_ADMIN_USER\n"
	echo "Flush privileges / reload permissions on db\n"

	#Commands pour tout le setup de msql
	mysql -u  root  --skip-password <<- EOF 
		USE mysql;
		FLUSH PRIVILEGES;
		DELETE FROM	mysql.user WHERE User='';
		DROP DATABASE test;
		DELETE FROM mysql.db WHERE Db='test';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';

		CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE CHARACTER SET utf8mb4;
		CREATE USER IF NOT EXISTS '$WP_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PWD';
		GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$WP_ADMIN_USER'@'%';
		FLUSH PRIVILEGES;
	EOF


	sleep 2
	echo "Shutdown msqli, configuration finished"
	mysqladmin -uroot -p"$ROOT_PASSWORD" shutdown
	sleep 2
else
	echo "\nSkipping initialization because Mysql database is already created"
fi

sleep 5

echo "Starting mariadb server\n"
exec mysqld -u root
