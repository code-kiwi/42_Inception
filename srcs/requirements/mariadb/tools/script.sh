#!/bin/bash
set -e

# Check that necessary variables exist
: "${MYSQL_ROOT_PASSWORD:?Variable MYSQL_ROOT_PASSWORD undefined}"
: "${MYSQL_DATABASE:?Variable MYSQL_DATABASE undefined}"
: "${MYSQL_USER:?Variable MYSQL_USER undefined}"
: "${MYSQL_PASSWORD:?Variable MYSQL_PASSWORD undefined}"

echo "[INFO] MariaDB initialization..."

# Start MariaDB in the background
mysqld_safe --skip-networking &
echo "[INFO] Waiting for MariaDB to start..."
until mysqladmin ping &>/dev/null; do sleep 1; done

# Check if DB to create
DB_EXISTS=$(mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';" | grep "$MYSQL_DATABASE" || true)

if [ -z "$DB_EXISTS" ];
then
    # Execute sql init script
    echo "[INFO] Database $MYSQL_DATABASE missing. Creation script execution..."
    envsubst < /usr/local/bin/init.sql | mysql -u root
else
    echo "[INFO] Database $MYSQL_DATABASE already existing..."
fi

# Shut down temporary instance
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB normally
echo "[INFO] MariaDB start..."
exec mysqld_safe