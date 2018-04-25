FROM debian:stretch

MAINTAINER Victor Seva <linuxmaniac@torreviejawireless.org>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2018-04-25

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio51 stretch main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update && apt-get install --assume-yes kamailio=5.1.3+stretch kamailio-autheph-modules=5.1.3+stretch kamailio-berkeley-bin=5.1.3+stretch kamailio-berkeley-modules=5.1.3+stretch kamailio-carrierroute-modules=5.1.3+stretch kamailio-cnxcc-modules=5.1.3+stretch kamailio-cpl-modules=5.1.3+stretch kamailio-dbg=5.1.3+stretch kamailio-erlang-modules=5.1.3+stretch kamailio-extra-modules=5.1.3+stretch kamailio-geoip-modules=5.1.3+stretch kamailio-geoip2-modules=5.1.3+stretch kamailio-ims-modules=5.1.3+stretch kamailio-java-modules=5.1.3+stretch kamailio-json-modules=5.1.3+stretch kamailio-kazoo-modules=5.1.3+stretch kamailio-ldap-modules=5.1.3+stretch kamailio-lua-modules=5.1.3+stretch kamailio-memcached-modules=5.1.3+stretch kamailio-mongodb-modules=5.1.3+stretch kamailio-mono-modules=5.1.3+stretch kamailio-mysql-modules=5.1.3+stretch kamailio-nth=5.1.3+stretch kamailio-outbound-modules=5.1.3+stretch kamailio-perl-modules=5.1.3+stretch kamailio-phonenum-modules=5.1.3+stretch kamailio-postgres-modules=5.1.3+stretch kamailio-presence-modules=5.1.3+stretch kamailio-python-modules=5.1.3+stretch kamailio-rabbitmq-modules=5.1.3+stretch kamailio-radius-modules=5.1.3+stretch kamailio-redis-modules=5.1.3+stretch kamailio-sctp-modules=5.1.3+stretch kamailio-snmpstats-modules=5.1.3+stretch kamailio-sqlite-modules=5.1.3+stretch kamailio-systemd-modules=5.1.3+stretch kamailio-tls-modules=5.1.3+stretch kamailio-unixodbc-modules=5.1.3+stretch kamailio-utils-modules=5.1.3+stretch kamailio-websocket-modules=5.1.3+stretch kamailio-xml-modules=5.1.3+stretch kamailio-xmpp-modules=5.1.3+stretch

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
