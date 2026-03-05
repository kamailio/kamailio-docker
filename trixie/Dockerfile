FROM debian:trixie

LABEL org.opencontainers.image.authors="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2026-03-05
RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget apt-transport-https
# kamailio repo
RUN echo "deb https://deb-archive.kamailio.org/repos/kamailio-6.0.6 trixie main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O /tmp/kamailiodebkey.gpg https://deb.kamailio.org/kamailiodebkey.gpg &&   gpg --output /etc/apt/trusted.gpg.d/deb-kamailio-org.gpg --dearmor /tmp/kamailiodebkey.gpg
RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes kamailio=6.0.6+bpo13 kamailio-autheph-modules=6.0.6+bpo13 kamailio-berkeley-bin=6.0.6+bpo13 kamailio-berkeley-modules=6.0.6+bpo13 kamailio-cnxcc-modules=6.0.6+bpo13 kamailio-cpl-modules=6.0.6+bpo13 kamailio-dbg=6.0.6+bpo13 kamailio-erlang-modules=6.0.6+bpo13 kamailio-extra-modules=6.0.6+bpo13 kamailio-geoip2-modules=6.0.6+bpo13 kamailio-ims-modules=6.0.6+bpo13 kamailio-json-modules=6.0.6+bpo13 kamailio-kafka-modules=6.0.6+bpo13 kamailio-kazoo-modules=6.0.6+bpo13 kamailio-ldap-modules=6.0.6+bpo13 kamailio-lua-modules=6.0.6+bpo13 kamailio-lwsc-modules=6.0.6+bpo13 kamailio-memcached-modules=6.0.6+bpo13 kamailio-microhttpd-modules=6.0.6+bpo13 kamailio-mongodb-modules=6.0.6+bpo13 kamailio-mqtt-modules=6.0.6+bpo13 kamailio-mysql-modules=6.0.6+bpo13 kamailio-nats-modules=6.0.6+bpo13 kamailio-nth=6.0.6+bpo13 kamailio-outbound-modules=6.0.6+bpo13 kamailio-perl-modules=6.0.6+bpo13 kamailio-phonenum-modules=6.0.6+bpo13 kamailio-postgres-modules=6.0.6+bpo13 kamailio-presence-modules=6.0.6+bpo13 kamailio-python3-modules=6.0.6+bpo13 kamailio-rabbitmq-modules=6.0.6+bpo13 kamailio-radius-modules=6.0.6+bpo13 kamailio-redis-modules=6.0.6+bpo13 kamailio-ruby-modules=6.0.6+bpo13 kamailio-sctp-modules=6.0.6+bpo13 kamailio-secsipid-modules=6.0.6+bpo13 kamailio-snmpstats-modules=6.0.6+bpo13 kamailio-sqlite-modules=6.0.6+bpo13 kamailio-systemd-modules=6.0.6+bpo13 kamailio-tls-modules=6.0.6+bpo13 kamailio-tls-wolfssl-modules=6.0.6+bpo13 kamailio-unixodbc-modules=6.0.6+bpo13 kamailio-utils-modules=6.0.6+bpo13 kamailio-websocket-modules=6.0.6+bpo13 kamailio-xml-modules=6.0.6+bpo13 kamailio-xmpp-modules=6.0.6+bpo13   && apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=64
ENV PKG_MEMORY=8

VOLUME /etc/kamailio
ENTRYPOINT kamailio -DD -E -m ${SHM_MEMORY} -M ${PKG_MEMORY}
