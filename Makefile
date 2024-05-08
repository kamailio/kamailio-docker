DISTS ?= bookworm bullseye buster stretch jammy focal bionic xenial

VERSION ?= 5.7.5

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
