FROM debian:12

RUN apt update -y \
    && apt upgrade -y \
    && apt install mariadb-server gettext-base -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/lib/mysql /run/mysqld \
	&& chown mysql:mysql /var/lib/mysql /run/mysqld

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

CMD ["mysqld_safe"]

EXPOSE 3306