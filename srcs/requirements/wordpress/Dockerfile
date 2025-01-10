FROM debian@sha256:cd73f5c112f19fac6d67b49d8982104fcf9c14b4ad69c2658fab8702f61b4430

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-cgi \
    wget \
    unzip \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Install wp-cli 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp-cli.phar

# Copy wordpress conf

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/.

RUN mkdir -p /run/php

COPY ./tools/wp-launch.sh .
RUN chmod +x wp-launch.sh

ENTRYPOINT ["./wp-launch.sh"]
CMD ["php-fpm8.2", "-F"]


