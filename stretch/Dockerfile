FROM debian/eol:stretch

LABEL org.opencontainers.image.authors Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2024-07-03
# fix repositories
RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' -e '/security.debian.org/d' -e '/stretch-updates/d' /etc/apt/sources.list
RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget apt-transport-https
# kamailio repo
RUN echo "deb https://deb-archive.kamailio.org/repos/kamailio-5.7.6 stretch main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- https://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -
RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes kamailio=5.7.6+bpo9 kamailio-autheph-modules=5.7.6+bpo9 kamailio-berkeley-bin=5.7.6+bpo9 kamailio-berkeley-modules=5.7.6+bpo9 kamailio-cnxcc-modules=5.7.6+bpo9 kamailio-cpl-modules=5.7.6+bpo9 kamailio-dbg=5.7.6+bpo9 kamailio-erlang-modules=5.7.6+bpo9 kamailio-extra-modules=5.7.6+bpo9 kamailio-geoip-modules=5.7.6+bpo9 kamailio-geoip2-modules=5.7.6+bpo9 kamailio-ims-modules=5.7.6+bpo9 kamailio-java-modules=5.7.6+bpo9 kamailio-json-modules=5.7.6+bpo9 kamailio-kazoo-modules=5.7.6+bpo9 kamailio-ldap-modules=5.7.6+bpo9 kamailio-lua-modules=5.7.6+bpo9 kamailio-memcached-modules=5.7.6+bpo9 kamailio-mongodb-modules=5.7.6+bpo9 kamailio-mono-modules=5.7.6+bpo9 kamailio-mqtt-modules=5.7.6+bpo9 kamailio-mysql-modules=5.7.6+bpo9 kamailio-nth=5.7.6+bpo9 kamailio-outbound-modules=5.7.6+bpo9 kamailio-perl-modules=5.7.6+bpo9 kamailio-phonenum-modules=5.7.6+bpo9 kamailio-postgres-modules=5.7.6+bpo9 kamailio-presence-modules=5.7.6+bpo9 kamailio-python-modules=5.7.6+bpo9 kamailio-python3-modules=5.7.6+bpo9 kamailio-rabbitmq-modules=5.7.6+bpo9 kamailio-radius-modules=5.7.6+bpo9 kamailio-redis-modules=5.7.6+bpo9 kamailio-ruby-modules=5.7.6+bpo9 kamailio-sctp-modules=5.7.6+bpo9 kamailio-snmpstats-modules=5.7.6+bpo9 kamailio-sqlite-modules=5.7.6+bpo9 kamailio-systemd-modules=5.7.6+bpo9 kamailio-tls-modules=5.7.6+bpo9 kamailio-unixodbc-modules=5.7.6+bpo9 kamailio-utils-modules=5.7.6+bpo9 kamailio-websocket-modules=5.7.6+bpo9 kamailio-xml-modules=5.7.6+bpo9 kamailio-xmpp-modules=5.7.6+bpo9   && apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=64
ENV PKG_MEMORY=8

VOLUME /etc/kamailio
ENTRYPOINT kamailio -DD -E -m ${SHM_MEMORY} -M ${PKG_MEMORY}
