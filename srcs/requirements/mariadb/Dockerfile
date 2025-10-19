FROM debian:12

RUN apt update -y \
    && apt upgrade -y \
    && apt install mariadb-server gettext-base -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql \
	&& chown mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD ["mysqld_safe"]
