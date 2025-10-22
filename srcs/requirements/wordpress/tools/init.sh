#!/bin/sh
set -e

# Check that necessary variables exist
: "${MYSQL_DATABASE:?Variable MYSQL_DATABASE undefined}"
: "${MYSQL_USER:?Variable MYSQL_USER undefined}"
: "${MYSQL_PASSWORD:?Variable MYSQL_PASSWORD undefined}"
: "${DOMAIN_NAME:?Variable DOMAIN_NAME undefined}"
: "${SITE_TITLE:?Variable SITE_TITLE undefined}"
: "${WP_ADMIN:?Variable WP_ADMIN undefined}"
: "${WP_ADMIN_PASSWORD:?Variable WP_ADMIN_PASSWORD undefined}"
: "${WP_ADMIN_EMAIL:?Variable WP_ADMIN_EMAIL undefined}"
: "${WP_USER:?Variable WP_USER undefined}"
: "${WP_USER_EMAIL:?Variable WP_USER_EMAIL undefined}"
: "${WP_USER_PASSWORD:?Variable WP_USER_PASSWORD undefined}"

# Download WP for CLI install
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Ensure WP directory exists
mkdir -p /var/www/html
cd /var/www/html

# WP install
if [ ! -e wp-config.php ]; then
        echo "[INFO] WordPress install..."

        # Download wp core files
        wp core download --allow-root

        # Configure wp database info
        wp core config \
            --dbname="${MYSQL_DATABASE}" \
            --dbuser="${MYSQL_USER}" \
            --dbpass="${MYSQL_PASSWORD}" \
            --dbhost='mariadb:3306' \
            --allow-root

        # Install WP setting up admin
        wp core install \
            --url="${DOMAIN_NAME}" \
            --title="${SITE_TITLE}" \
            --admin_user="${WP_ADMIN}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --allow-root 

        # Create one more user
        wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
            --role=author \
            --user_pass="${WP_USER_PASSWORD}" \
            --allow-root
else
    echo "[INFO] WordPress already installed..."
fi

# exec php-fpm8.2 -F
exec php-fpm8.2 --nodaemonize --fpm-config /etc/php82/php-fpm.d/www.conf