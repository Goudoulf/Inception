FROM debian@sha256:e83913597ca9deb9d699316a9a9d806c2a87ed61195ac66ae0a8ac55089a84b9

RUN apt-get update && \
    apt-get install -y \
      php-cli \
      php-mysql \
      curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www && curl -fsSL "https://www.adminer.org/latest.php" -o /var/www/adminer.php

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www"]
