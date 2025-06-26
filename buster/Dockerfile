FROM debian:buster

LABEL org.opencontainers.image.authors="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2025-06-26
RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget apt-transport-https
# kamailio repo
RUN echo "deb https://deb-archive.kamailio.org/repos/kamailio-6.0.2 buster main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- https://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -
RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes kamailio=6.0.2+bpo10 kamailio-autheph-modules=6.0.2+bpo10 kamailio-berkeley-bin=6.0.2+bpo10 kamailio-berkeley-modules=6.0.2+bpo10 kamailio-cnxcc-modules=6.0.2+bpo10 kamailio-cpl-modules=6.0.2+bpo10 kamailio-dbg=6.0.2+bpo10 kamailio-erlang-modules=6.0.2+bpo10 kamailio-extra-modules=6.0.2+bpo10 kamailio-geoip2-modules=6.0.2+bpo10 kamailio-ims-modules=6.0.2+bpo10 kamailio-json-modules=6.0.2+bpo10 kamailio-kazoo-modules=6.0.2+bpo10 kamailio-ldap-modules=6.0.2+bpo10 kamailio-lua-modules=6.0.2+bpo10 kamailio-memcached-modules=6.0.2+bpo10 kamailio-mongodb-modules=6.0.2+bpo10 kamailio-mqtt-modules=6.0.2+bpo10 kamailio-mysql-modules=6.0.2+bpo10 kamailio-nth=6.0.2+bpo10 kamailio-outbound-modules=6.0.2+bpo10 kamailio-perl-modules=6.0.2+bpo10 kamailio-phonenum-modules=6.0.2+bpo10 kamailio-postgres-modules=6.0.2+bpo10 kamailio-presence-modules=6.0.2+bpo10 kamailio-python-modules=6.0.2+bpo10 kamailio-python3-modules=6.0.2+bpo10 kamailio-rabbitmq-modules=6.0.2+bpo10 kamailio-radius-modules=6.0.2+bpo10 kamailio-redis-modules=6.0.2+bpo10 kamailio-ruby-modules=6.0.2+bpo10 kamailio-sctp-modules=6.0.2+bpo10 kamailio-snmpstats-modules=6.0.2+bpo10 kamailio-sqlite-modules=6.0.2+bpo10 kamailio-systemd-modules=6.0.2+bpo10 kamailio-tls-modules=6.0.2+bpo10 kamailio-tls-wolfssl-modules=6.0.2+bpo10 kamailio-unixodbc-modules=6.0.2+bpo10 kamailio-utils-modules=6.0.2+bpo10 kamailio-websocket-modules=6.0.2+bpo10 kamailio-xml-modules=6.0.2+bpo10 kamailio-xmpp-modules=6.0.2+bpo10   && apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=64
ENV PKG_MEMORY=8

VOLUME /etc/kamailio
ENTRYPOINT kamailio -DD -E -m ${SHM_MEMORY} -M ${PKG_MEMORY}
