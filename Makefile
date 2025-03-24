DISTS ?= bookworm bullseye buster stretch noble jammy focal bionic xenial

VERSION ?= 5.8.6

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
