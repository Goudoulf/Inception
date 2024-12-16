FROM debian:12.8

RUN apt-get update && \
    apt-get install -y nginx && apt install -y openssl &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/L=Lyon/O=42/OU=student/CN=[cassie.42.fr](http://cassie.42.fr/)"
# Copy SSL certificates
# COPY conf/server.crt /etc/nginx/ssl/server.crt
# COPY conf/server.key /etc/nginx/ssl/server.key

# Copy custom Nginx configuration
COPY ./conf/default /etc/nginx/sites-available/.

# EXPOSE 80 443 
#
# LABEL version="1.0"
# # LABEL description="My Nginx Server"
#
CMD ["nginx", "-g", "daemon off;"]
