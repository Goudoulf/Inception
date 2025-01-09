FROM debian@sha256:cd73f5c112f19fac6d67b49d8982104fcf9c14b4ad69c2658fab8702f61b4430

RUN apt-get update && apt-get install -y --no-install-recommends \
	mariadb-server && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/start.sh .

ENTRYPOINT ["./start.sh"]
