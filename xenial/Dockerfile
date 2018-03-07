FROM ubuntu:xenial

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2018-03-07

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio51 xenial main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.1.2+xenial kamailio-autheph-modules=5.1.2+xenial kamailio-berkeley-bin=5.1.2+xenial kamailio-berkeley-modules=5.1.2+xenial kamailio-carrierroute-modules=5.1.2+xenial kamailio-cnxcc-modules=5.1.2+xenial kamailio-cpl-modules=5.1.2+xenial kamailio-dbg=5.1.2+xenial kamailio-dnssec-modules=5.1.2+xenial kamailio-erlang-modules=5.1.2+xenial kamailio-extra-modules=5.1.2+xenial kamailio-geoip-modules=5.1.2+xenial kamailio-geoip2-modules=5.1.2+xenial kamailio-ims-modules=5.1.2+xenial kamailio-java-modules=5.1.2+xenial kamailio-json-modules=5.1.2+xenial kamailio-kazoo-modules=5.1.2+xenial kamailio-ldap-modules=5.1.2+xenial kamailio-lua-modules=5.1.2+xenial kamailio-memcached-modules=5.1.2+xenial kamailio-mongodb-modules=5.1.2+xenial kamailio-mono-modules=5.1.2+xenial kamailio-mysql-modules=5.1.2+xenial kamailio-nth=5.1.2+xenial kamailio-outbound-modules=5.1.2+xenial kamailio-perl-modules=5.1.2+xenial kamailio-phonenum-modules=5.1.2+xenial kamailio-postgres-modules=5.1.2+xenial kamailio-presence-modules=5.1.2+xenial kamailio-python-modules=5.1.2+xenial kamailio-rabbitmq-modules=5.1.2+xenial kamailio-radius-modules=5.1.2+xenial kamailio-redis-modules=5.1.2+xenial kamailio-sctp-modules=5.1.2+xenial kamailio-snmpstats-modules=5.1.2+xenial kamailio-sqlite-modules=5.1.2+xenial kamailio-systemd-modules=5.1.2+xenial kamailio-tls-modules=5.1.2+xenial kamailio-unixodbc-modules=5.1.2+xenial kamailio-utils-modules=5.1.2+xenial kamailio-websocket-modules=5.1.2+xenial kamailio-xml-modules=5.1.2+xenial kamailio-xmpp-modules=5.1.2+xenial

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
