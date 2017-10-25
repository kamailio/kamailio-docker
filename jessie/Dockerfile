FROM debian:jessie

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2017-10-25

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio50 jessie main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.0.4+jessie kamailio-autheph-modules=5.0.4+jessie kamailio-carrierroute-modules=5.0.4+jessie kamailio-cnxcc-modules=5.0.4+jessie kamailio-cpl-modules=5.0.4+jessie kamailio-dbg=5.0.4+jessie kamailio-dnssec-modules=5.0.4+jessie kamailio-erlang-modules=5.0.4+jessie kamailio-extra-modules=5.0.4+jessie kamailio-geoip-modules=5.0.4+jessie kamailio-ims-modules=5.0.4+jessie kamailio-java-modules=5.0.4+jessie kamailio-json-modules=5.0.4+jessie kamailio-kazoo-modules=5.0.4+jessie kamailio-ldap-modules=5.0.4+jessie kamailio-lua-modules=5.0.4+jessie kamailio-memcached-modules=5.0.4+jessie kamailio-mono-modules=5.0.4+jessie kamailio-mysql-modules=5.0.4+jessie kamailio-nth=5.0.4+jessie kamailio-outbound-modules=5.0.4+jessie kamailio-perl-modules=5.0.4+jessie kamailio-postgres-modules=5.0.4+jessie kamailio-presence-modules=5.0.4+jessie kamailio-python-modules=5.0.4+jessie kamailio-rabbitmq-modules=5.0.4+jessie kamailio-radius-modules=5.0.4+jessie kamailio-redis-modules=5.0.4+jessie kamailio-sctp-modules=5.0.4+jessie kamailio-snmpstats-modules=5.0.4+jessie kamailio-sqlite-modules=5.0.4+jessie kamailio-systemd-modules=5.0.4+jessie kamailio-tls-modules=5.0.4+jessie kamailio-unixodbc-modules=5.0.4+jessie kamailio-utils-modules=5.0.4+jessie kamailio-websocket-modules=5.0.4+jessie kamailio-xml-modules=5.0.4+jessie kamailio-xmpp-modules=5.0.4+jessie

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
