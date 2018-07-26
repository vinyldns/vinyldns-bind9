FROM alpine:3.6

RUN apk --update upgrade && \
    apk add --update bind && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/cache/bind/zones && \
    mkdir -p /var/cache/bind/config && \
    mkdir -p /var/log/named

# zones are copied in before running
# the config directory should contain named.conf.local containing
# your zone configs and keys
VOLUME ["/var/cache/bind/zones", "/var/cache/bind/config"]

COPY files/bind/* /etc/bind/

ADD entrypoint.sh /entrypoint.sh

RUN chmod 750 /entrypoint.sh

EXPOSE 53/udp 53/tcp

WORKDIR /etc/bind

CMD ["/entrypoint.sh"]
