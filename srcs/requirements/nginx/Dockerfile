FROM debian@sha256:cd73f5c112f19fac6d67b49d8982104fcf9c14b4ad69c2658fab8702f61b4430

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R www-data:www-data /var/www/html \
	&& chmod -R 755 /var/www/html

# Copy Nginx configuration

COPY ./conf/default /etc/nginx/sites-available/default

# Copy certificate 

COPY ./conf/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY ./conf/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt 

CMD ["nginx", "-g", "daemon off;"]
