FROM debian:stretch

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2020-05-14

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio52 stretch main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.2.7+bpo9 kamailio-autheph-modules=5.2.7+bpo9 kamailio-berkeley-bin=5.2.7+bpo9 kamailio-berkeley-modules=5.2.7+bpo9 kamailio-cnxcc-modules=5.2.7+bpo9 kamailio-cpl-modules=5.2.7+bpo9 kamailio-dbg=5.2.7+bpo9 kamailio-erlang-modules=5.2.7+bpo9 kamailio-extra-modules=5.2.7+bpo9 kamailio-geoip-modules=5.2.7+bpo9 kamailio-geoip2-modules=5.2.7+bpo9 kamailio-ims-modules=5.2.7+bpo9 kamailio-java-modules=5.2.7+bpo9 kamailio-json-modules=5.2.7+bpo9 kamailio-kazoo-modules=5.2.7+bpo9 kamailio-ldap-modules=5.2.7+bpo9 kamailio-lua-modules=5.2.7+bpo9 kamailio-memcached-modules=5.2.7+bpo9 kamailio-mongodb-modules=5.2.7+bpo9 kamailio-mono-modules=5.2.7+bpo9 kamailio-mysql-modules=5.2.7+bpo9 kamailio-nth=5.2.7+bpo9 kamailio-outbound-modules=5.2.7+bpo9 kamailio-perl-modules=5.2.7+bpo9 kamailio-phonenum-modules=5.2.7+bpo9 kamailio-postgres-modules=5.2.7+bpo9 kamailio-presence-modules=5.2.7+bpo9 kamailio-python-modules=5.2.7+bpo9 kamailio-python3-modules=5.2.7+bpo9 kamailio-rabbitmq-modules=5.2.7+bpo9 kamailio-radius-modules=5.2.7+bpo9 kamailio-redis-modules=5.2.7+bpo9 kamailio-ruby-modules=5.2.7+bpo9 kamailio-sctp-modules=5.2.7+bpo9 kamailio-snmpstats-modules=5.2.7+bpo9 kamailio-sqlite-modules=5.2.7+bpo9 kamailio-systemd-modules=5.2.7+bpo9 kamailio-tls-modules=5.2.7+bpo9 kamailio-unixodbc-modules=5.2.7+bpo9 kamailio-utils-modules=5.2.7+bpo9 kamailio-websocket-modules=5.2.7+bpo9 kamailio-xml-modules=5.2.7+bpo9 kamailio-xmpp-modules=5.2.7+bpo9

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
