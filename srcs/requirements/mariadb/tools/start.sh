#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

: "${MDB_ROOT_PASSWORD:?Need to set MDB_ROOT_PASSWORD}"
: "${MDB_DATABASE:?Need to set MDB_DATABASE}"
: "${MDB_USER:?Need to set MDB_USER}"
: "${MDB_USER_PASSWORD:?Need to set MDB_USER_PASSWORD}"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

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


