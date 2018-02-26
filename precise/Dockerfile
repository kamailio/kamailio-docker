FROM ubuntu:precise

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2018-02-26

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio51 precise main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.1.1+precise kamailio-autheph-modules=5.1.1+precise kamailio-berkeley-bin=5.1.1+precise kamailio-berkeley-modules=5.1.1+precise kamailio-carrierroute-modules=5.1.1+precise kamailio-cpl-modules=5.1.1+precise kamailio-dbg=5.1.1+precise kamailio-erlang-modules=5.1.1+precise kamailio-extra-modules=5.1.1+precise kamailio-geoip-modules=5.1.1+precise kamailio-ims-modules=5.1.1+precise kamailio-java-modules=5.1.1+precise kamailio-json-modules=5.1.1+precise kamailio-ldap-modules=5.1.1+precise kamailio-lua-modules=5.1.1+precise kamailio-memcached-modules=5.1.1+precise kamailio-mono-modules=5.1.1+precise kamailio-mysql-modules=5.1.1+precise kamailio-nth=5.1.1+precise kamailio-outbound-modules=5.1.1+precise kamailio-perl-modules=5.1.1+precise kamailio-postgres-modules=5.1.1+precise kamailio-presence-modules=5.1.1+precise kamailio-python-modules=5.1.1+precise kamailio-radius-modules=5.1.1+precise kamailio-redis-modules=5.1.1+precise kamailio-sctp-modules=5.1.1+precise kamailio-snmpstats-modules=5.1.1+precise kamailio-sqlite-modules=5.1.1+precise kamailio-tls-modules=5.1.1+precise kamailio-unixodbc-modules=5.1.1+precise kamailio-utils-modules=5.1.1+precise kamailio-websocket-modules=5.1.1+precise kamailio-xml-modules=5.1.1+precise kamailio-xmpp-modules=5.1.1+precise

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
