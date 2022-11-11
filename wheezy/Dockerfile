FROM debian/eol:wheezy

LABEL maintainer="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2022-11-11

RUN rm -rf /var/lib/apt/lists/* && apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio54 wheezy main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes kamailio=5.4.6+bpo7 kamailio-autheph-modules=5.4.6+bpo7 kamailio-berkeley-bin=5.4.6+bpo7 kamailio-berkeley-modules=5.4.6+bpo7 kamailio-cpl-modules=5.4.6+bpo7 kamailio-dbg=5.4.6+bpo7 kamailio-erlang-modules=5.4.6+bpo7 kamailio-extra-modules=5.4.6+bpo7 kamailio-geoip-modules=5.4.6+bpo7 kamailio-ims-modules=5.4.6+bpo7 kamailio-java-modules=5.4.6+bpo7 kamailio-json-modules=5.4.6+bpo7 kamailio-ldap-modules=5.4.6+bpo7 kamailio-lua-modules=5.4.6+bpo7 kamailio-memcached-modules=5.4.6+bpo7 kamailio-mono-modules=5.4.6+bpo7 kamailio-mysql-modules=5.4.6+bpo7 kamailio-nth=5.4.6+bpo7 kamailio-outbound-modules=5.4.6+bpo7 kamailio-perl-modules=5.4.6+bpo7 kamailio-postgres-modules=5.4.6+bpo7 kamailio-presence-modules=5.4.6+bpo7 kamailio-python-modules=5.4.6+bpo7 kamailio-radius-modules=5.4.6+bpo7 kamailio-redis-modules=5.4.6+bpo7 kamailio-sctp-modules=5.4.6+bpo7 kamailio-snmpstats-modules=5.4.6+bpo7 kamailio-sqlite-modules=5.4.6+bpo7 kamailio-tls-modules=5.4.6+bpo7 kamailio-unixodbc-modules=5.4.6+bpo7 kamailio-utils-modules=5.4.6+bpo7 kamailio-websocket-modules=5.4.6+bpo7 kamailio-xml-modules=5.4.6+bpo7 kamailio-xmpp-modules=5.4.6+bpo7

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=${SHM_MEMORY:-64}
ENV PKG_MEMORY=${PKG_MEMORY:-8}

ENTRYPOINT ["kamailio", "-DD", "-E", "-m ${SHM_MEMORY}", "-M ${PKG_MEMORY}"]
