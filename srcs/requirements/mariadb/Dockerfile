FROM debian:12

# Install MariaDB server
RUN apt update && \
	apt upgrade && \
    apt install -y mariadb-server gettext-base && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /usr/local/bin/script.sh
COPY tools/init.sql /usr/local/bin/init.sql
RUN chmod +x /usr/local/bin/script.sh

# Create necessary directories
RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld

# Expose port 3306
EXPOSE 3306

# Start MariaDB
ENTRYPOINT ["/usr/local/bin/script.sh"]
CMD [ "mysqld" ]