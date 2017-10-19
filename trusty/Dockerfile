FROM ubuntu:trusty

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2017-10-19

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gpg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio50 trusty main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.0.3+trusty kamailio-autheph-modules=5.0.3+trusty kamailio-carrierroute-modules=5.0.3+trusty kamailio-cnxcc-modules=5.0.3+trusty kamailio-cpl-modules=5.0.3+trusty kamailio-dbg=5.0.3+trusty kamailio-dnssec-modules=5.0.3+trusty kamailio-erlang-modules=5.0.3+trusty kamailio-extra-modules=5.0.3+trusty kamailio-geoip-modules=5.0.3+trusty kamailio-ims-modules=5.0.3+trusty kamailio-java-modules=5.0.3+trusty kamailio-json-modules=5.0.3+trusty kamailio-kazoo-modules=5.0.3+trusty kamailio-ldap-modules=5.0.3+trusty kamailio-lua-modules=5.0.3+trusty kamailio-memcached-modules=5.0.3+trusty kamailio-mono-modules=5.0.3+trusty kamailio-mysql-modules=5.0.3+trusty kamailio-nth=5.0.3+trusty kamailio-outbound-modules=5.0.3+trusty kamailio-perl-modules=5.0.3+trusty kamailio-postgres-modules=5.0.3+trusty kamailio-presence-modules=5.0.3+trusty kamailio-python-modules=5.0.3+trusty kamailio-rabbitmq-modules=5.0.3+trusty kamailio-radius-modules=5.0.3+trusty kamailio-redis-modules=5.0.3+trusty kamailio-sctp-modules=5.0.3+trusty kamailio-snmpstats-modules=5.0.3+trusty kamailio-sqlite-modules=5.0.3+trusty kamailio-tls-modules=5.0.3+trusty kamailio-unixodbc-modules=5.0.3+trusty kamailio-utils-modules=5.0.3+trusty kamailio-websocket-modules=5.0.3+trusty kamailio-xml-modules=5.0.3+trusty kamailio-xmpp-modules=5.0.3+trusty

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
