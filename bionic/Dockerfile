FROM ubuntu:bionic

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2020-03-24

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio53 bionic main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.3.3+bionic kamailio-autheph-modules=5.3.3+bionic kamailio-berkeley-bin=5.3.3+bionic kamailio-berkeley-modules=5.3.3+bionic kamailio-cnxcc-modules=5.3.3+bionic kamailio-cpl-modules=5.3.3+bionic kamailio-dbg=5.3.3+bionic kamailio-erlang-modules=5.3.3+bionic kamailio-extra-modules=5.3.3+bionic kamailio-geoip-modules=5.3.3+bionic kamailio-geoip2-modules=5.3.3+bionic kamailio-ims-modules=5.3.3+bionic kamailio-json-modules=5.3.3+bionic kamailio-kazoo-modules=5.3.3+bionic kamailio-ldap-modules=5.3.3+bionic kamailio-lua-modules=5.3.3+bionic kamailio-memcached-modules=5.3.3+bionic kamailio-mongodb-modules=5.3.3+bionic kamailio-mono-modules=5.3.3+bionic kamailio-mysql-modules=5.3.3+bionic kamailio-nth=5.3.3+bionic kamailio-outbound-modules=5.3.3+bionic kamailio-perl-modules=5.3.3+bionic kamailio-phonenum-modules=5.3.3+bionic kamailio-postgres-modules=5.3.3+bionic kamailio-presence-modules=5.3.3+bionic kamailio-python-modules=5.3.3+bionic kamailio-python3-modules=5.3.3+bionic kamailio-rabbitmq-modules=5.3.3+bionic kamailio-radius-modules=5.3.3+bionic kamailio-redis-modules=5.3.3+bionic kamailio-ruby-modules=5.3.3+bionic kamailio-sctp-modules=5.3.3+bionic kamailio-snmpstats-modules=5.3.3+bionic kamailio-sqlite-modules=5.3.3+bionic kamailio-systemd-modules=5.3.3+bionic kamailio-tls-modules=5.3.3+bionic kamailio-unixodbc-modules=5.3.3+bionic kamailio-utils-modules=5.3.3+bionic kamailio-websocket-modules=5.3.3+bionic kamailio-xml-modules=5.3.3+bionic kamailio-xmpp-modules=5.3.3+bionic

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
