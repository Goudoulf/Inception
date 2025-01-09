#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

: "${MDB_ROOT_PASSWORD:?Need to set MDB_ROOT_PASSWORD}"
: "${MDB_DATABASE:?Need to set MDB_DATABASE}"
: "${MDB_USER:?Need to set MDB_USER}"
: "${MDB_USER_PASSWORD:?Need to set MDB_USER_PASSWORD}"

# Ensure mysqld run directory exists and set correct permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# If no database is initialized, set it up
if [ ! -d "/var/lib/mysql/mysql" ]; then

    # Initialize the database directory
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

    # Run initial SQL statements to configure the database and users
    mysqld --user=mysql --bootstrap <<-EOSQL
        USE mysql;
        FLUSH PRIVILEGES;

        DELETE FROM mysql.user WHERE User='';
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASSWORD}';

        CREATE DATABASE ${MDB_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
        CREATE USER '${MDB_USER}'@'%' IDENTIFIED BY '${MDB_USER_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MDB_DATABASE}.* TO '${MDB_USER}'@'%';

        FLUSH PRIVILEGES;
EOSQL
fi

# Start MariaDB in the foreground

echo "Starting MariaDB server..."
exec mysqld --user=mysql --console

