#!/bin/bash
kam_packages() {
  wget -q -O /tmp/Packages "http://deb.kamailio.org/kamailio${kam_version}/dists/${dist}/main/binary-amd64/Packages"
  repo_version=$(awk '/Version:/ { print $2 }' /tmp/Packages| head -1)
  awk -vver="${repo_version}" '/Package:/ { print $2"="ver}' /tmp/Packages | xargs
}

create_dockerfile() {
  cat >"${DOCKERFILE}" <<EOF
FROM ${base}:${dist}

LABEL maintainer="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT ${DATE}

EOF

if [ -n "${archived}" ] ; then
cat >>"${DOCKERFILE}" <<EOF
RUN echo "deb http://archive.debian.org/debian ${dist} main" > \
  /etc/apt/sources.list; \
  echo "deb http://archive.debian.org/debian ${dist}-lts main" >> \
    /etc/apt/sources.list ; \
  echo "Acquire::Check-Valid-Until false;" >> /etc/apt/apt.conf

EOF
elif [ "${base}" = "debian" ] ; then
cat >>"${DOCKERFILE}" <<EOF
# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

EOF
fi
cat >>"${DOCKERFILE}" <<EOF
RUN rm -rf /var/lib/apt/lists/* && apt-get update && \
  apt-get install --assume-yes gnupg wget
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio${kam_version} ${dist} main" > \
  /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

EOF

cat >>"${DOCKERFILE}" <<EOF
RUN apt-get update && apt-get install --assume-yes ${PKGS}

VOLUME /etc/kamailio

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["kamailio", "-DD", "-E"]
EOF
}

dist=${1:-stretch}
version=${2:-5.0.3}
DATE=$(date +"%Y-%m-%d")

case ${dist} in
  focal|bionic|xenial|trusty|precise) base=ubuntu ;;
  squeeze|wheezy|jessie|stretch|buster) base=debian ;;
  *)
    echo "ERROR: no ${dist} base supported"
    exit 1
    ;;
esac

case ${dist} in
  squeeze) archived=true ;;
esac

case ${version} in
  5\.4*)
    echo "5.4 series"
    kam_version="54"
    ;;
  5\.3*)
    echo "5.3 series"
    kam_version="53"
    ;;
  5\.2*)
    echo "5.2 series"
    kam_version="52"
    ;;
  5\.1*)
    echo "5.1 series"
    kam_version="51"
    ;;
  5\.0*)
    echo "5.0 series"
    kam_version="50"
    ;;
  4\.4*)
    echo "4.4 series"
    kam_version="44"
    ;;
  *)
    echo "unknown kamailio version '${version}'"
    exit 1;;
esac

PKGS=$(kam_packages)
mkdir -p "${dist}/${version}"
DOCKERFILE="${dist}/Dockerfile"
create_dockerfile
