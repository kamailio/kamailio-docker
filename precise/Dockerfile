FROM ubuntu:precise

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2021-01-15

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio53 precise main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.3.5+ubuntu12.04 kamailio-autheph-modules=5.3.5+ubuntu12.04 kamailio-berkeley-bin=5.3.5+ubuntu12.04 kamailio-berkeley-modules=5.3.5+ubuntu12.04 kamailio-cpl-modules=5.3.5+ubuntu12.04 kamailio-dbg=5.3.5+ubuntu12.04 kamailio-erlang-modules=5.3.5+ubuntu12.04 kamailio-extra-modules=5.3.5+ubuntu12.04 kamailio-geoip-modules=5.3.5+ubuntu12.04 kamailio-ims-modules=5.3.5+ubuntu12.04 kamailio-java-modules=5.3.5+ubuntu12.04 kamailio-json-modules=5.3.5+ubuntu12.04 kamailio-ldap-modules=5.3.5+ubuntu12.04 kamailio-lua-modules=5.3.5+ubuntu12.04 kamailio-memcached-modules=5.3.5+ubuntu12.04 kamailio-mono-modules=5.3.5+ubuntu12.04 kamailio-mysql-modules=5.3.5+ubuntu12.04 kamailio-nth=5.3.5+ubuntu12.04 kamailio-outbound-modules=5.3.5+ubuntu12.04 kamailio-perl-modules=5.3.5+ubuntu12.04 kamailio-postgres-modules=5.3.5+ubuntu12.04 kamailio-presence-modules=5.3.5+ubuntu12.04 kamailio-python-modules=5.3.5+ubuntu12.04 kamailio-radius-modules=5.3.5+ubuntu12.04 kamailio-redis-modules=5.3.5+ubuntu12.04 kamailio-sctp-modules=5.3.5+ubuntu12.04 kamailio-snmpstats-modules=5.3.5+ubuntu12.04 kamailio-sqlite-modules=5.3.5+ubuntu12.04 kamailio-tls-modules=5.3.5+ubuntu12.04 kamailio-unixodbc-modules=5.3.5+ubuntu12.04 kamailio-utils-modules=5.3.5+ubuntu12.04 kamailio-websocket-modules=5.3.5+ubuntu12.04 kamailio-xml-modules=5.3.5+ubuntu12.04 kamailio-xmpp-modules=5.3.5+ubuntu12.04

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
