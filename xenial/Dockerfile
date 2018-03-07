FROM ubuntu:xenial

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2018-03-07

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio44 xenial main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=4.4.7+xenial kamailio-autheph-modules=4.4.7+xenial kamailio-carrierroute-modules=4.4.7+xenial kamailio-cnxcc-modules=4.4.7+xenial kamailio-cpl-modules=4.4.7+xenial kamailio-dbg=4.4.7+xenial kamailio-dnssec-modules=4.4.7+xenial kamailio-erlang-modules=4.4.7+xenial kamailio-extra-modules=4.4.7+xenial kamailio-geoip-modules=4.4.7+xenial kamailio-ims-modules=4.4.7+xenial kamailio-java-modules=4.4.7+xenial kamailio-json-modules=4.4.7+xenial kamailio-kazoo-modules=4.4.7+xenial kamailio-ldap-modules=4.4.7+xenial kamailio-lua-modules=4.4.7+xenial kamailio-memcached-modules=4.4.7+xenial kamailio-mono-modules=4.4.7+xenial kamailio-mysql-modules=4.4.7+xenial kamailio-nth=4.4.7+xenial kamailio-outbound-modules=4.4.7+xenial kamailio-perl-modules=4.4.7+xenial kamailio-postgres-modules=4.4.7+xenial kamailio-presence-modules=4.4.7+xenial kamailio-purple-modules=4.4.7+xenial kamailio-python-modules=4.4.7+xenial kamailio-radius-modules=4.4.7+xenial kamailio-redis-modules=4.4.7+xenial kamailio-sctp-modules=4.4.7+xenial kamailio-snmpstats-modules=4.4.7+xenial kamailio-sqlite-modules=4.4.7+xenial kamailio-tls-modules=4.4.7+xenial kamailio-unixodbc-modules=4.4.7+xenial kamailio-utils-modules=4.4.7+xenial kamailio-websocket-modules=4.4.7+xenial kamailio-xml-modules=4.4.7+xenial kamailio-xmpp-modules=4.4.7+xenial

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
