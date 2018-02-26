FROM debian:wheezy

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2018-02-26

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio51 wheezy main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.1.1+wheezy kamailio-autheph-modules=5.1.1+wheezy kamailio-berkeley-bin=5.1.1+wheezy kamailio-berkeley-modules=5.1.1+wheezy kamailio-carrierroute-modules=5.1.1+wheezy kamailio-cpl-modules=5.1.1+wheezy kamailio-dbg=5.1.1+wheezy kamailio-erlang-modules=5.1.1+wheezy kamailio-extra-modules=5.1.1+wheezy kamailio-geoip-modules=5.1.1+wheezy kamailio-ims-modules=5.1.1+wheezy kamailio-java-modules=5.1.1+wheezy kamailio-json-modules=5.1.1+wheezy kamailio-ldap-modules=5.1.1+wheezy kamailio-lua-modules=5.1.1+wheezy kamailio-memcached-modules=5.1.1+wheezy kamailio-mono-modules=5.1.1+wheezy kamailio-mysql-modules=5.1.1+wheezy kamailio-nth=5.1.1+wheezy kamailio-outbound-modules=5.1.1+wheezy kamailio-perl-modules=5.1.1+wheezy kamailio-postgres-modules=5.1.1+wheezy kamailio-presence-modules=5.1.1+wheezy kamailio-python-modules=5.1.1+wheezy kamailio-radius-modules=5.1.1+wheezy kamailio-redis-modules=5.1.1+wheezy kamailio-sctp-modules=5.1.1+wheezy kamailio-snmpstats-modules=5.1.1+wheezy kamailio-sqlite-modules=5.1.1+wheezy kamailio-tls-modules=5.1.1+wheezy kamailio-unixodbc-modules=5.1.1+wheezy kamailio-utils-modules=5.1.1+wheezy kamailio-websocket-modules=5.1.1+wheezy kamailio-xml-modules=5.1.1+wheezy kamailio-xmpp-modules=5.1.1+wheezy

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
