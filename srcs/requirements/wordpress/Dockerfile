FROM debian:12.8

ENV DEBIAN_FRONTEND=noninteractive \
    WORDPRESS_VERSION=6.3.2 \
    WORDPRESS_DIR=/var/www/html \
    PHP_FPM_PORT=9000

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    wget \
    unzip \
    curl \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY ./tools/wp-launch.sh .

RUN chmod +x wp-launch.sh
# RUN sed -i "s/listen = .*/listen = 0.0.0.0:${PHP_FPM_PORT}/" /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i "s/;clear_env = no/clear_env = no/" /etc/php/7.4/fpm/pool.d/www.conf

#EXPOSE ${PHP_FPM_PORT}

#WORKDIR ${WORDPRESS_DIR}

CMD ["./wp-launch.sh"]

