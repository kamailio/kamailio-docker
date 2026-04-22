DISTS ?= trixie bookworm bullseye noble jammy

VERSION ?= 6.1.2

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
