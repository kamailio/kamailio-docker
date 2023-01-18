DISTS ?= bookworm bullseye buster jessie stretch focal bionic trusty xenial

VERSION ?= 5.6.3

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
