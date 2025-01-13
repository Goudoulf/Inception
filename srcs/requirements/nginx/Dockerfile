FROM debian@sha256:e83913597ca9deb9d699316a9a9d806c2a87ed61195ac66ae0a8ac55089a84b9

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
