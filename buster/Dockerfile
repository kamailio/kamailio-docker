FROM debian:buster

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2019-03-21

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio52 buster main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.2.2+buster kamailio-autheph-modules=5.2.2+buster kamailio-berkeley-bin=5.2.2+buster kamailio-berkeley-modules=5.2.2+buster kamailio-cnxcc-modules=5.2.2+buster kamailio-cpl-modules=5.2.2+buster kamailio-dbg=5.2.2+buster kamailio-erlang-modules=5.2.2+buster kamailio-extra-modules=5.2.2+buster kamailio-geoip-modules=5.2.2+buster kamailio-geoip2-modules=5.2.2+buster kamailio-ims-modules=5.2.2+buster kamailio-json-modules=5.2.2+buster kamailio-kazoo-modules=5.2.2+buster kamailio-ldap-modules=5.2.2+buster kamailio-lua-modules=5.2.2+buster kamailio-memcached-modules=5.2.2+buster kamailio-mongodb-modules=5.2.2+buster kamailio-mono-modules=5.2.2+buster kamailio-mysql-modules=5.2.2+buster kamailio-nth=5.2.2+buster kamailio-outbound-modules=5.2.2+buster kamailio-perl-modules=5.2.2+buster kamailio-phonenum-modules=5.2.2+buster kamailio-postgres-modules=5.2.2+buster kamailio-presence-modules=5.2.2+buster kamailio-python-modules=5.2.2+buster kamailio-python3-modules=5.2.2+buster kamailio-rabbitmq-modules=5.2.2+buster kamailio-radius-modules=5.2.2+buster kamailio-redis-modules=5.2.2+buster kamailio-ruby-modules=5.2.2+buster kamailio-sctp-modules=5.2.2+buster kamailio-snmpstats-modules=5.2.2+buster kamailio-sqlite-modules=5.2.2+buster kamailio-systemd-modules=5.2.2+buster kamailio-tls-modules=5.2.2+buster kamailio-unixodbc-modules=5.2.2+buster kamailio-utils-modules=5.2.2+buster kamailio-websocket-modules=5.2.2+buster kamailio-xml-modules=5.2.2+buster kamailio-xmpp-modules=5.2.2+buster

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
