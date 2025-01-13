FROM debian@sha256:e83913597ca9deb9d699316a9a9d806c2a87ed61195ac66ae0a8ac55089a84b9

RUN apt-get update && \
    apt-get install -y --no-install-recommends lighttpd && \
    rm -rf /var/lib/apt/lists/*

COPY . /var/www/html/

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

