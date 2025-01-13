FROM debian@sha256:e83913597ca9deb9d699316a9a9d806c2a87ed61195ac66ae0a8ac55089a84b9

RUN apt-get update && apt-get install -y --no-install-recommends \
	mariadb-server \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/start.sh .

ENTRYPOINT ["./start.sh"]
CMD ["mysqld", "--console", "--bind-address=0.0.0.0"]
