DISTS ?= trixie bookworm bullseye noble jammy focal bionic

VERSION ?= 6.0.6

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
