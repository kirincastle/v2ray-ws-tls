from nginx:latest

ENV CLIENT_ID "38c9e20b-f90f-4bc6-a909-fa2b10917925"
ENV CLIENT_ALTERID 64
ENV CLIENT_SECURITY aes-128-gcm
ENV CLIENT_DOMAIN abc.abc.abc
ENV VER=3.5

ADD conf/nginx.conf /etc/nginx/
ADD conf/default.conf /etc/nginx/conf.d/
ADD entrypoint.sh /etc/

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl wget unzip php7.2-fpm

RUN source <(curl -sL https://multi.netlify.com/v2ray.sh) --zh

RUN chmod -R 777 /var/log/nginx /var/cache/nginx /var/run \
	&& chgrp -R 0 /etc/nginx \
	&& chmod -R g+rwx /etc/nginx \
	&& mkdir /run/php/ \
	&& chmod -R 777 /var/log/ /run/php/ \
	&& mkdir /var/log/v2ray \
	&& mkdir /etc/v2ray \
	&& chmod -R 777 /var/log/v2ray \
	&& chmod -R 777 /etc/v2ray \
	&& chmod 777 /etc/entrypoint.sh \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/cache/apt/*

RUN 

ADD conf/config.json /etc/v2ray/
ADD conf/www.conf /etc/php/7.2/fpm/pool.d/

EXPOSE 8080
ENTRYPOINT ["/etc/entrypoint.sh"]
