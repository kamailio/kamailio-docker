FROM ubuntu:focal

LABEL maintainer="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2023-03-03

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio55 focal main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes kamailio=5.5.6+ubuntu20.04 kamailio-autheph-modules=5.5.6+ubuntu20.04 kamailio-berkeley-bin=5.5.6+ubuntu20.04 kamailio-berkeley-modules=5.5.6+ubuntu20.04 kamailio-cnxcc-modules=5.5.6+ubuntu20.04 kamailio-cpl-modules=5.5.6+ubuntu20.04 kamailio-dbg=5.5.6+ubuntu20.04 kamailio-erlang-modules=5.5.6+ubuntu20.04 kamailio-extra-modules=5.5.6+ubuntu20.04 kamailio-geoip-modules=5.5.6+ubuntu20.04 kamailio-geoip2-modules=5.5.6+ubuntu20.04 kamailio-ims-modules=5.5.6+ubuntu20.04 kamailio-json-modules=5.5.6+ubuntu20.04 kamailio-kazoo-modules=5.5.6+ubuntu20.04 kamailio-ldap-modules=5.5.6+ubuntu20.04 kamailio-lua-modules=5.5.6+ubuntu20.04 kamailio-lwsc-modules=5.5.6+ubuntu20.04 kamailio-memcached-modules=5.5.6+ubuntu20.04 kamailio-mongodb-modules=5.5.6+ubuntu20.04 kamailio-mono-modules=5.5.6+ubuntu20.04 kamailio-mqtt-modules=5.5.6+ubuntu20.04 kamailio-mysql-modules=5.5.6+ubuntu20.04 kamailio-nth=5.5.6+ubuntu20.04 kamailio-outbound-modules=5.5.6+ubuntu20.04 kamailio-perl-modules=5.5.6+ubuntu20.04 kamailio-phonenum-modules=5.5.6+ubuntu20.04 kamailio-postgres-modules=5.5.6+ubuntu20.04 kamailio-presence-modules=5.5.6+ubuntu20.04 kamailio-python-modules=5.5.6+ubuntu20.04 kamailio-python3-modules=5.5.6+ubuntu20.04 kamailio-rabbitmq-modules=5.5.6+ubuntu20.04 kamailio-radius-modules=5.5.6+ubuntu20.04 kamailio-redis-modules=5.5.6+ubuntu20.04 kamailio-ruby-modules=5.5.6+ubuntu20.04 kamailio-sctp-modules=5.5.6+ubuntu20.04 kamailio-snmpstats-modules=5.5.6+ubuntu20.04 kamailio-sqlite-modules=5.5.6+ubuntu20.04 kamailio-systemd-modules=5.5.6+ubuntu20.04 kamailio-tls-modules=5.5.6+ubuntu20.04 kamailio-unixodbc-modules=5.5.6+ubuntu20.04 kamailio-utils-modules=5.5.6+ubuntu20.04 kamailio-websocket-modules=5.5.6+ubuntu20.04 kamailio-xml-modules=5.5.6+ubuntu20.04 kamailio-xmpp-modules=5.5.6+ubuntu20.04

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=64
ENV PKG_MEMORY=8

ENTRYPOINT kamailio -DD -E -m ${SHM_MEMORY} -M ${PKG_MEMORY}
