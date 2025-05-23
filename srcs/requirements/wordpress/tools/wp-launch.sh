#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

: "${MDB_HOSTNAME:?Need to set MDB_HOSTNAME}"
: "${MDB_USER:?Need to set MDB_USER}"
: "${MDB_USER_PASSWORD:?Need to set MDB_USER_PASSWORD}"
: "${WP_ROOT:?Need to set WP_ROOT}"
: "${WP_ROOT_PASSWORD:?Need to set WP_ROOT_PASSWORD}"
: "${MDB_DATABASE:?Need to set MDB_DATABASE}"
: "${DOMAIN_NAME:?Need to set DOMAIN_NAME}"

cd /var/www/html

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
wp-cli.phar core download --allow-root
wp-cli.phar config create --dbname=$MDB_DATABASE --dbuser=$MDB_USER --dbpass=$MDB_USER_PASSWORD --dbhost=$MDB_HOSTNAME --allow-root
wp-cli.phar core install --url=$DOMAIN_NAME --title=Inception --admin_user=$WP_ROOT --admin_password=$WP_ROOT_PASSWORD --admin_email=cassie@student.42lyon.fr --allow-root
wp-cli.phar theme activate twentytwentyfour --allow-root

fi

exec "$@"
