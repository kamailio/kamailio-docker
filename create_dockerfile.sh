#!/bin/bash
dist=${1:-bookworm}
version=${2:-5.7.4}
DATE=$(date +"%Y-%m-%d")

KAM_ARCHIVE_REPO="https://deb-archive.kamailio.org/repos/kamailio-${version}"

get_kam_repo() {
  if ! wget -q -O /tmp/Packages "${KAM_ARCHIVE_REPO}/dists/${dist}/main/binary-amd64/Packages" ; then
    echo "https://deb.kamailio.org/kamailio${kam_version}"
  else
    echo "${KAM_ARCHIVE_REPO}"
  fi
}

get_kam_version() {
  if [[ ${version} =~ 4\.4\.[0-9] ]] ; then
    kam_version="44"
  elif [[ ${version} =~ 5\.([0-9])\.[0-9] ]] ; then
    kam_version="5${BASH_REMATCH[1]}"
  else
    echo "unknown kamailio version '${version}'" >&2
  fi
}

kam_packages() {
  if ! wget -q -O /tmp/Packages "${KAM_ARCHIVE_REPO}/dists/${dist}/main/binary-amd64/Packages" ; then
    KAM_REPO="https://deb.kamailio.org/kamailio${kam_version}"
    wget -q -O /tmp/Packages "${KAM_REPO}/dists/${dist}/main/binary-amd64/Packages"
  fi
  repo_version=$(awk '/Version:/ { print $2 }' /tmp/Packages| head -1)
  if [[ ${repo_version} =~ ^${version} ]] ; then
    awk -vver="${repo_version}" '/Package:/ { print $2"="ver}' /tmp/Packages | xargs
  else
    echo "packages in repository \"deb ${KAM_REPO} ${dist} main\" doesn't match version: [${version}]" >&2
    echo "version in repository: [${repo_version}]" >&2
  fi
}

create_dockerfile() {
  cat >"${DOCKERFILE}" <<EOF
FROM ${docker_tag}

LABEL org.opencontainers.image.authors="Victor Seva <linuxmaniac@torreviejawireless.org>"

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=${DATE}
EOF

if ${archived} ; then
  cat >>"${DOCKERFILE}" <<EOF
# fix repositories
${RULE}
EOF
fi

  cat >>"${DOCKERFILE}" <<EOF
RUN rm -rf /var/lib/apt/lists/* && apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes gnupg wget apt-transport-https
# kamailio repo
RUN echo "deb ${KAM_REPO} ${dist} main" > \
  /etc/apt/sources.list.d/kamailio.list
EOF

if ${apt_key} ; then
  echo "RUN wget -O- https://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -" >> ${DOCKERFILE}
else
  cat >>"${DOCKERFILE}" <<EOF
RUN wget -O /tmp/kamailiodebkey.gpg https://deb.kamailio.org/kamailiodebkey.gpg && \
  gpg --output /etc/apt/trusted.gpg.d/deb-kamailio-org.gpg --dearmor /tmp/kamailiodebkey.gpg
EOF
fi

cat >>"${DOCKERFILE}" <<EOF
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes ${PKGS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# set SHM_MEMORY and PKG_MEMORY from ENV
ENV SHM_MEMORY=${SHM_MEMORY:-64}
ENV PKG_MEMORY=${PKG_MEMORY:-8}

VOLUME /etc/kamailio
ENTRYPOINT kamailio -DD -E -m \${SHM_MEMORY} -M \${PKG_MEMORY}
EOF
}

case ${dist} in
  noble|jammy|focal|bionic|xenial|trusty|precise) base=ubuntu ;;
  squeeze|wheezy|jessie|stretch|buster|bullseye|bookworm) base=debian ;;
  *)
    echo "ERROR: no ${dist} base supported"
    exit 1
    ;;
esac

case ${dist} in
  squeeze|wheezy|jessie|stretch) docker_tag=${base}/eol:${dist};;
  *) docker_tag=${base}:${dist}
esac

case ${dist} in
  bookworm) apt_key=false ;;
  *) apt_key=true
esac

archived=false
case ${dist} in
  precise)
    archived=true ; MIRROR=old-release.ubuntu.com
    RULE="RUN sed -i -e 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list"
    ;;
  squeeze|wheezy|jessie|stretch)
    archived=true ; MIRROR=archive.debian.org
    RULE="RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' -e '/security.debian.org/d' -e '/${dist}-updates/d' /etc/apt/sources.list"
    ;;
esac

get_kam_version
KAM_REPO=$(get_kam_repo)
PKGS=$(kam_packages)
[ -n "${PKGS}" ] || exit 1
mkdir -p "${dist}"
DOCKERFILE="${dist}/Dockerfile"
create_dockerfile
