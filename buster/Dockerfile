FROM debian:buster

LABEL maintainer="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2023-04-18

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget
# kamailio repo
#RUN echo "deb http://deb.kamailio.org/kamailio56 buster main" >   /etc/apt/sources.list.d/kamailio.list
RUN echo "deb [trusted=yes] http://scudnetworks.com:8003/scudrepo/public buster main" > /etc/apt/sources.list.d/scudRepo.list
#RUN wget -O- http://scudnetworks.com:8003/repo/scudRepo.gpg | apt-key add -
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes kamailio=5.6.4 kamailio-autheph-modules=5.6.4 kamailio-berkeley-bin=5.6.4 kamailio-berkeley-modules=5.6.4 kamailio-cnxcc-modules=5.6.4 kamailio-cpl-modules=5.6.4 kamailio-dbg=5.6.4 kamailio-erlang-modules=5.6.4 kamailio-extra-modules=5.6.4 kamailio-geoip-modules=5.6.4 kamailio-geoip2-modules=5.6.4 kamailio-ims-modules=5.6.4 kamailio-json-modules=5.6.4 kamailio-kazoo-modules=5.6.4 kamailio-ldap-modules=5.6.4 kamailio-lua-modules=5.6.4 kamailio-memcached-modules=5.6.4 kamailio-mongodb-modules=5.6.4 kamailio-mono-modules=5.6.4 kamailio-mqtt-modules=5.6.4 kamailio-mysql-modules=5.6.4 kamailio-nth=5.6.4 kamailio-outbound-modules=5.6.4 kamailio-perl-modules=5.6.4 kamailio-phonenum-modules=5.6.4 kamailio-postgres-modules=5.6.4 kamailio-presence-modules=5.6.4 kamailio-python-modules=5.6.4 kamailio-python3-modules=5.6.4 kamailio-rabbitmq-modules=5.6.4 kamailio-radius-modules=5.6.4 kamailio-redis-modules=5.6.4 kamailio-ruby-modules=5.6.4 kamailio-sctp-modules=5.6.4 kamailio-snmpstats-modules=5.6.4 kamailio-sqlite-modules=5.6.4 kamailio-systemd-modules=5.6.4 kamailio-tls-modules=5.6.4 kamailio-unixodbc-modules=5.6.4 kamailio-utils-modules=5.6.4 kamailio-websocket-modules=5.6.4 kamailio-xml-modules=5.6.4 kamailio-xmpp-modules=5.6.4 kamailio-kafka-modules=5.6.4

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=128
ENV PKG_MEMORY=64

ENTRYPOINT kamailio -DD -E -m ${SHM_MEMORY} -M ${PKG_MEMORY}
