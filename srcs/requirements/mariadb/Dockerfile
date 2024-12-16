FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY ./conf/init.sql /etc/mysql/init.sql
COPY ./conf/launch.sh .

RUN mkdir /run/mysqld -p && chmod +x launch.sh

CMD ["./launch.sh"]

