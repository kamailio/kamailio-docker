FROM debian:buster

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2020-08-25

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio54 buster main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.4.0+bpo10 kamailio-autheph-modules=5.4.0+bpo10 kamailio-berkeley-bin=5.4.0+bpo10 kamailio-berkeley-modules=5.4.0+bpo10 kamailio-cnxcc-modules=5.4.0+bpo10 kamailio-cpl-modules=5.4.0+bpo10 kamailio-dbg=5.4.0+bpo10 kamailio-erlang-modules=5.4.0+bpo10 kamailio-extra-modules=5.4.0+bpo10 kamailio-geoip-modules=5.4.0+bpo10 kamailio-geoip2-modules=5.4.0+bpo10 kamailio-ims-modules=5.4.0+bpo10 kamailio-json-modules=5.4.0+bpo10 kamailio-kazoo-modules=5.4.0+bpo10 kamailio-ldap-modules=5.4.0+bpo10 kamailio-lua-modules=5.4.0+bpo10 kamailio-memcached-modules=5.4.0+bpo10 kamailio-mongodb-modules=5.4.0+bpo10 kamailio-mono-modules=5.4.0+bpo10 kamailio-mqtt-modules=5.4.0+bpo10 kamailio-mysql-modules=5.4.0+bpo10 kamailio-nth=5.4.0+bpo10 kamailio-outbound-modules=5.4.0+bpo10 kamailio-perl-modules=5.4.0+bpo10 kamailio-phonenum-modules=5.4.0+bpo10 kamailio-postgres-modules=5.4.0+bpo10 kamailio-presence-modules=5.4.0+bpo10 kamailio-python-modules=5.4.0+bpo10 kamailio-python3-modules=5.4.0+bpo10 kamailio-rabbitmq-modules=5.4.0+bpo10 kamailio-radius-modules=5.4.0+bpo10 kamailio-redis-modules=5.4.0+bpo10 kamailio-ruby-modules=5.4.0+bpo10 kamailio-sctp-modules=5.4.0+bpo10 kamailio-snmpstats-modules=5.4.0+bpo10 kamailio-sqlite-modules=5.4.0+bpo10 kamailio-systemd-modules=5.4.0+bpo10 kamailio-tls-modules=5.4.0+bpo10 kamailio-unixodbc-modules=5.4.0+bpo10 kamailio-utils-modules=5.4.0+bpo10 kamailio-websocket-modules=5.4.0+bpo10 kamailio-xml-modules=5.4.0+bpo10 kamailio-xmpp-modules=5.4.0+bpo10

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
