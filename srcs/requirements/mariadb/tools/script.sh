#!/bin/bash

# --- Variables pour le test ---
export MYSQL_ROOT_PASSWORD=root_pass
export MYSQL_DATABASE=testdb
export MYSQL_USER=testuser
export MYSQL_PASSWORD=testpass

echo "[INFO] Ensuring database and user exist..."

# Start MariaDB in the background
mysqld_safe --skip-networking &
sleep 10

# Create DB and user
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Shut down temporary instance
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB normally
exec mysqld_safe