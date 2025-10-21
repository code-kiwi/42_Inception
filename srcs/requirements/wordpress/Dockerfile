FROM debian:12

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget mariadb-client php php-fpm php-mysqli php-phar php-iconv \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

COPY ./tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/init.sh"]
