FROM debian@sha256:cd73f5c112f19fac6d67b49d8982104fcf9c14b4ad69c2658fab8702f61b4430

RUN apt-get update && \
    apt-get install -y \
      php-cli \
      php-mysql \
      curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www && curl -fsSL "https://www.adminer.org/latest.php" -o /var/www/adminer.php

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www"]
