FROM ubuntu:precise

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2017-10-19

# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio44 precise main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=4.4.6+precise kamailio-autheph-modules=4.4.6+precise kamailio-carrierroute-modules=4.4.6+precise kamailio-cpl-modules=4.4.6+precise kamailio-dbg=4.4.6+precise kamailio-erlang-modules=4.4.6+precise kamailio-extra-modules=4.4.6+precise kamailio-geoip-modules=4.4.6+precise kamailio-ims-modules=4.4.6+precise kamailio-java-modules=4.4.6+precise kamailio-json-modules=4.4.6+precise kamailio-ldap-modules=4.4.6+precise kamailio-lua-modules=4.4.6+precise kamailio-memcached-modules=4.4.6+precise kamailio-mono-modules=4.4.6+precise kamailio-mysql-modules=4.4.6+precise kamailio-nth=4.4.6+precise kamailio-outbound-modules=4.4.6+precise kamailio-perl-modules=4.4.6+precise kamailio-postgres-modules=4.4.6+precise kamailio-presence-modules=4.4.6+precise kamailio-purple-modules=4.4.6+precise kamailio-python-modules=4.4.6+precise kamailio-radius-modules=4.4.6+precise kamailio-redis-modules=4.4.6+precise kamailio-sctp-modules=4.4.6+precise kamailio-snmpstats-modules=4.4.6+precise kamailio-sqlite-modules=4.4.6+precise kamailio-tls-modules=4.4.6+precise kamailio-unixodbc-modules=4.4.6+precise kamailio-utils-modules=4.4.6+precise kamailio-websocket-modules=4.4.6+precise kamailio-xml-modules=4.4.6+precise kamailio-xmpp-modules=4.4.6+precise

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
