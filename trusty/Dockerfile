FROM ubuntu:trusty

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2017-10-19

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio44 trusty main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=4.4.6+trusty kamailio-autheph-modules=4.4.6+trusty kamailio-carrierroute-modules=4.4.6+trusty kamailio-cnxcc-modules=4.4.6+trusty kamailio-cpl-modules=4.4.6+trusty kamailio-dbg=4.4.6+trusty kamailio-dnssec-modules=4.4.6+trusty kamailio-erlang-modules=4.4.6+trusty kamailio-extra-modules=4.4.6+trusty kamailio-geoip-modules=4.4.6+trusty kamailio-ims-modules=4.4.6+trusty kamailio-java-modules=4.4.6+trusty kamailio-json-modules=4.4.6+trusty kamailio-kazoo-modules=4.4.6+trusty kamailio-ldap-modules=4.4.6+trusty kamailio-lua-modules=4.4.6+trusty kamailio-memcached-modules=4.4.6+trusty kamailio-mono-modules=4.4.6+trusty kamailio-mysql-modules=4.4.6+trusty kamailio-nth=4.4.6+trusty kamailio-outbound-modules=4.4.6+trusty kamailio-perl-modules=4.4.6+trusty kamailio-postgres-modules=4.4.6+trusty kamailio-presence-modules=4.4.6+trusty kamailio-purple-modules=4.4.6+trusty kamailio-python-modules=4.4.6+trusty kamailio-radius-modules=4.4.6+trusty kamailio-redis-modules=4.4.6+trusty kamailio-sctp-modules=4.4.6+trusty kamailio-snmpstats-modules=4.4.6+trusty kamailio-sqlite-modules=4.4.6+trusty kamailio-tls-modules=4.4.6+trusty kamailio-unixodbc-modules=4.4.6+trusty kamailio-utils-modules=4.4.6+trusty kamailio-websocket-modules=4.4.6+trusty kamailio-xml-modules=4.4.6+trusty kamailio-xmpp-modules=4.4.6+trusty

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
