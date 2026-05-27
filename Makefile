DISTS ?= trixie bookworm bullseye resolute noble jammy

VERSION ?= 6.1.3

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
