FROM debian@sha256:cd73f5c112f19fac6d67b49d8982104fcf9c14b4ad69c2658fab8702f61b4430

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      vsftpd \
      openssl \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/ftpuser -s /bin/bash ftpuser && \
    echo "ftpuser:ftppassword" | chpasswd

# 3) Copy our vsftpd config (we'll write this file next)
COPY vsftpd.conf /etc/vsftpd.conf

# 4) Create SSL certificate (optional if you want FTPS)
#    Remove this if you don't plan on using SSL/TLS
RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/vsftpd.key \
    -out /etc/ssl/private/vsftpd.crt \
    -subj "/C=FR/ST=SomeState/L=SomeCity/O=SomeOrg/OU=IT/CN=example.com"

# 5) Expose FTP ports
EXPOSE 21           # Default FTP port
EXPOSE 21000-21010  # Passive ports (example range)

# 6) CMD to run vsftpd in the foreground
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]

