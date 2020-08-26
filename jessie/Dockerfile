FROM debian:jessie

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2020-08-26

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio53 jessie main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.3.5+bpo8 kamailio-autheph-modules=5.3.5+bpo8 kamailio-berkeley-bin=5.3.5+bpo8 kamailio-berkeley-modules=5.3.5+bpo8 kamailio-cnxcc-modules=5.3.5+bpo8 kamailio-cpl-modules=5.3.5+bpo8 kamailio-dbg=5.3.5+bpo8 kamailio-dnssec-modules=5.3.5+bpo8 kamailio-erlang-modules=5.3.5+bpo8 kamailio-extra-modules=5.3.5+bpo8 kamailio-geoip-modules=5.3.5+bpo8 kamailio-ims-modules=5.3.5+bpo8 kamailio-java-modules=5.3.5+bpo8 kamailio-json-modules=5.3.5+bpo8 kamailio-kazoo-modules=5.3.5+bpo8 kamailio-ldap-modules=5.3.5+bpo8 kamailio-lua-modules=5.3.5+bpo8 kamailio-memcached-modules=5.3.5+bpo8 kamailio-mono-modules=5.3.5+bpo8 kamailio-mysql-modules=5.3.5+bpo8 kamailio-nth=5.3.5+bpo8 kamailio-outbound-modules=5.3.5+bpo8 kamailio-perl-modules=5.3.5+bpo8 kamailio-postgres-modules=5.3.5+bpo8 kamailio-presence-modules=5.3.5+bpo8 kamailio-python-modules=5.3.5+bpo8 kamailio-python3-modules=5.3.5+bpo8 kamailio-rabbitmq-modules=5.3.5+bpo8 kamailio-radius-modules=5.3.5+bpo8 kamailio-redis-modules=5.3.5+bpo8 kamailio-ruby-modules=5.3.5+bpo8 kamailio-sctp-modules=5.3.5+bpo8 kamailio-snmpstats-modules=5.3.5+bpo8 kamailio-sqlite-modules=5.3.5+bpo8 kamailio-systemd-modules=5.3.5+bpo8 kamailio-tls-modules=5.3.5+bpo8 kamailio-unixodbc-modules=5.3.5+bpo8 kamailio-utils-modules=5.3.5+bpo8 kamailio-websocket-modules=5.3.5+bpo8 kamailio-xml-modules=5.3.5+bpo8 kamailio-xmpp-modules=5.3.5+bpo8

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
