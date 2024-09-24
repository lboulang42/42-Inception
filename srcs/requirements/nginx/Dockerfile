FROM debian:bullseye

RUN apt-get -y update \
    && apt-get -y upgrade \ 
    && apt-get -y install nginx

RUN mkdir /var/log/nginx/wordpress/
RUN touch /var/log/nginx/wordpress/access.log
RUN touch /var/log/nginx/wordpress/error.log
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN apt-get -y install openssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout \ 
	/etc/ssl/private/inception.key -out /etc/ssl/certs/inception.crt \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42School/CN=lboulang.42.fr"


EXPOSE 443



ENTRYPOINT ["nginx", "-g", "daemon off;"]
