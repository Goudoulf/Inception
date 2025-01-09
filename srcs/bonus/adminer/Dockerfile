FROM debian@sha256:cd73f5c112f19fac6d67b49d8982104fcf9c14b4ad69c2658fab8702f61b4430

RUN apt-get update && apt-get install -y \
    adminer \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/share/adminer/

RUN ./compile.php

RUN mv adminer-*.php adminer.php

RUN echo "Alias /adminer.php /usr/share/adminer/adminer.php" | tee /etc/apache2/conf-available/adminer.conf

RUN a2enconf adminer.conf

RUN systemctl restart apache2

CMD ["nginx", "-g", "daemon off;"]
