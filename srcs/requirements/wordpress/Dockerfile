FROM debian:bullseye

RUN apt-get -y update \ 
	&& apt-get -y upgrade \
	&& apt-get -y update \
	&& apt-get -y install wget php7.4-fpm php7.4-mysql php7.4-json php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-xml php7.4-mbstring

#get the cli-script, move to /bin, change perm to execute
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /usr/local/bin/wp

#create dirs
RUN mkdir /run/php/ 
RUN mkdir /var/www/ && mkdir /var/www/wordpress
#change current dir && exec wpcore
WORKDIR /var/www/wordpress

RUN wp core download --version='6.4.3' --allow-root
RUN pwd && ls
#cp conf files
COPY ./conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY ./conf/www.conf    /etc/php/7.4/fpm/pool.d/www.conf

#change rights
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/wordpress

#cp tools
COPY ./tools/wp.sh /tmp/wp.sh
#add script rights
RUN chmod +x /tmp/wp.sh


ENTRYPOINT  /tmp/wp.sh 
