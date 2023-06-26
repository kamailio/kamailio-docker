DISTS ?= bookworm bullseye buster jessie stretch wheezy jammy focal bionic trusty xenial

VERSION ?= 5.5.0

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
