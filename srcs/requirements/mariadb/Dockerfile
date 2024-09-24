FROM debian:bullseye

RUN	apt-get -y update \
	&& apt-get -y install apt-utils mariadb-server mariadb-client \
	&& rm -rf /var/lib/mysql \
	&& mkdir -p /var/lib/mysql /run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql  /run/mysqld \
	&& chmod 777 /var/run/mysqld\
	&& apt-get -y install vim

VOLUME /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql/
COPY ./entrypoint.sh ./

EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]
