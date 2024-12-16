#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --initialize-insecure
    service mysql start

    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

    if [ ! -z "$MARIADB_DATABASE" ]; then
        mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"
    fi
    if [ ! -z "$MARIADB_USER" ] && [ ! -z "$MARIADB_PASSWORD" ]; then
        mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
        mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';"
    fi

    service mysql stop
fi

# Start MariaDB
exec "$@"
