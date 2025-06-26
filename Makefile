DISTS ?= bookworm bullseye buster stretch noble jammy focal bionic

VERSION ?= 6.0.2

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
