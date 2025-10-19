FROM debian:12

RUN apt update \
    && apt upgrade \
    && apt install -y nginx \
    && apt install -y openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/ssl_cert.crt -keyout /etc/nginx/ssl/ssl_key.key -subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=mhotting.42.fr/UID=mhotting"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
