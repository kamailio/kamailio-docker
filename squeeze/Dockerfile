FROM debian:squeeze

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2018-03-07

RUN echo "deb http://archive.debian.org/debian squeeze main" >   /etc/apt/sources.list;   echo "deb http://archive.debian.org/debian squeeze-lts main" >>     /etc/apt/sources.list ;   echo "Acquire::Check-Valid-Until false;" >> /etc/apt/apt.conf

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio44 squeeze main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=4.4.7+squeeze kamailio-autheph-modules=4.4.7+squeeze kamailio-carrierroute-modules=4.4.7+squeeze kamailio-cpl-modules=4.4.7+squeeze kamailio-dbg=4.4.7+squeeze kamailio-erlang-modules=4.4.7+squeeze kamailio-extra-modules=4.4.7+squeeze kamailio-geoip-modules=4.4.7+squeeze kamailio-ims-modules=4.4.7+squeeze kamailio-json-modules=4.4.7+squeeze kamailio-ldap-modules=4.4.7+squeeze kamailio-lua-modules=4.4.7+squeeze kamailio-memcached-modules=4.4.7+squeeze kamailio-mysql-modules=4.4.7+squeeze kamailio-nth=4.4.7+squeeze kamailio-outbound-modules=4.4.7+squeeze kamailio-perl-modules=4.4.7+squeeze kamailio-postgres-modules=4.4.7+squeeze kamailio-presence-modules=4.4.7+squeeze kamailio-python-modules=4.4.7+squeeze kamailio-radius-modules=4.4.7+squeeze kamailio-snmpstats-modules=4.4.7+squeeze kamailio-sqlite-modules=4.4.7+squeeze kamailio-tls-modules=4.4.7+squeeze kamailio-unixodbc-modules=4.4.7+squeeze kamailio-utils-modules=4.4.7+squeeze kamailio-websocket-modules=4.4.7+squeeze kamailio-xml-modules=4.4.7+squeeze kamailio-xmpp-modules=4.4.7+squeeze

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
