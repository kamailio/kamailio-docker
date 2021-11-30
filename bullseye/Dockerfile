FROM debian:bullseye

LABEL maintainer="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2021-11-30

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio55 bullseye main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.5.3+bpo11 kamailio-autheph-modules=5.5.3+bpo11 kamailio-berkeley-bin=5.5.3+bpo11 kamailio-berkeley-modules=5.5.3+bpo11 kamailio-cnxcc-modules=5.5.3+bpo11 kamailio-cpl-modules=5.5.3+bpo11 kamailio-dbg=5.5.3+bpo11 kamailio-erlang-modules=5.5.3+bpo11 kamailio-extra-modules=5.5.3+bpo11 kamailio-geoip-modules=5.5.3+bpo11 kamailio-geoip2-modules=5.5.3+bpo11 kamailio-ims-modules=5.5.3+bpo11 kamailio-json-modules=5.5.3+bpo11 kamailio-kazoo-modules=5.5.3+bpo11 kamailio-ldap-modules=5.5.3+bpo11 kamailio-lua-modules=5.5.3+bpo11 kamailio-lwsc-modules=5.5.3+bpo11 kamailio-memcached-modules=5.5.3+bpo11 kamailio-mongodb-modules=5.5.3+bpo11 kamailio-mono-modules=5.5.3+bpo11 kamailio-mqtt-modules=5.5.3+bpo11 kamailio-mysql-modules=5.5.3+bpo11 kamailio-nth=5.5.3+bpo11 kamailio-outbound-modules=5.5.3+bpo11 kamailio-perl-modules=5.5.3+bpo11 kamailio-phonenum-modules=5.5.3+bpo11 kamailio-postgres-modules=5.5.3+bpo11 kamailio-presence-modules=5.5.3+bpo11 kamailio-python-modules=5.5.3+bpo11 kamailio-python3-modules=5.5.3+bpo11 kamailio-rabbitmq-modules=5.5.3+bpo11 kamailio-radius-modules=5.5.3+bpo11 kamailio-redis-modules=5.5.3+bpo11 kamailio-ruby-modules=5.5.3+bpo11 kamailio-sctp-modules=5.5.3+bpo11 kamailio-secsipid-modules=5.5.3+bpo11 kamailio-snmpstats-modules=5.5.3+bpo11 kamailio-sqlite-modules=5.5.3+bpo11 kamailio-systemd-modules=5.5.3+bpo11 kamailio-tls-modules=5.5.3+bpo11 kamailio-unixodbc-modules=5.5.3+bpo11 kamailio-utils-modules=5.5.3+bpo11 kamailio-websocket-modules=5.5.3+bpo11 kamailio-xml-modules=5.5.3+bpo11 kamailio-xmpp-modules=5.5.3+bpo11

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
