FROM debian:wheezy

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2017-10-19

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gpg wget
# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio44 wheezy main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=4.4.6+wheezy kamailio-autheph-modules=4.4.6+wheezy kamailio-carrierroute-modules=4.4.6+wheezy kamailio-cpl-modules=4.4.6+wheezy kamailio-dbg=4.4.6+wheezy kamailio-erlang-modules=4.4.6+wheezy kamailio-extra-modules=4.4.6+wheezy kamailio-geoip-modules=4.4.6+wheezy kamailio-ims-modules=4.4.6+wheezy kamailio-java-modules=4.4.6+wheezy kamailio-json-modules=4.4.6+wheezy kamailio-ldap-modules=4.4.6+wheezy kamailio-lua-modules=4.4.6+wheezy kamailio-memcached-modules=4.4.6+wheezy kamailio-mono-modules=4.4.6+wheezy kamailio-mysql-modules=4.4.6+wheezy kamailio-nth=4.4.6+wheezy kamailio-outbound-modules=4.4.6+wheezy kamailio-perl-modules=4.4.6+wheezy kamailio-postgres-modules=4.4.6+wheezy kamailio-presence-modules=4.4.6+wheezy kamailio-python-modules=4.4.6+wheezy kamailio-radius-modules=4.4.6+wheezy kamailio-redis-modules=4.4.6+wheezy kamailio-sctp-modules=4.4.6+wheezy kamailio-snmpstats-modules=4.4.6+wheezy kamailio-sqlite-modules=4.4.6+wheezy kamailio-tls-modules=4.4.6+wheezy kamailio-unixodbc-modules=4.4.6+wheezy kamailio-utils-modules=4.4.6+wheezy kamailio-websocket-modules=4.4.6+wheezy kamailio-xml-modules=4.4.6+wheezy kamailio-xmpp-modules=4.4.6+wheezy

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
