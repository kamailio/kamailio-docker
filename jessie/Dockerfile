FROM debian:jessie

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2017-10-19

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio44 jessie main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=4.4.6+jessie kamailio-autheph-modules=4.4.6+jessie kamailio-carrierroute-modules=4.4.6+jessie kamailio-cnxcc-modules=4.4.6+jessie kamailio-cpl-modules=4.4.6+jessie kamailio-dbg=4.4.6+jessie kamailio-dnssec-modules=4.4.6+jessie kamailio-erlang-modules=4.4.6+jessie kamailio-extra-modules=4.4.6+jessie kamailio-geoip-modules=4.4.6+jessie kamailio-ims-modules=4.4.6+jessie kamailio-java-modules=4.4.6+jessie kamailio-json-modules=4.4.6+jessie kamailio-kazoo-modules=4.4.6+jessie kamailio-ldap-modules=4.4.6+jessie kamailio-lua-modules=4.4.6+jessie kamailio-memcached-modules=4.4.6+jessie kamailio-mono-modules=4.4.6+jessie kamailio-mysql-modules=4.4.6+jessie kamailio-nth=4.4.6+jessie kamailio-outbound-modules=4.4.6+jessie kamailio-perl-modules=4.4.6+jessie kamailio-postgres-modules=4.4.6+jessie kamailio-presence-modules=4.4.6+jessie kamailio-purple-modules=4.4.6+jessie kamailio-python-modules=4.4.6+jessie kamailio-radius-modules=4.4.6+jessie kamailio-redis-modules=4.4.6+jessie kamailio-sctp-modules=4.4.6+jessie kamailio-snmpstats-modules=4.4.6+jessie kamailio-sqlite-modules=4.4.6+jessie kamailio-tls-modules=4.4.6+jessie kamailio-unixodbc-modules=4.4.6+jessie kamailio-utils-modules=4.4.6+jessie kamailio-websocket-modules=4.4.6+jessie kamailio-xml-modules=4.4.6+jessie kamailio-xmpp-modules=4.4.6+jessie

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
