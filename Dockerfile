FROM debian:stretch

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		bind9 \
		dnsutils \
		iputils-ping \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps \
	&& rm -r /var/lib/apt/lists/* \
	&& mkdir /var/log/named \
	&& chown bind:bind /var/log/named \
	&& chmod 0755 /var/log/named

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
