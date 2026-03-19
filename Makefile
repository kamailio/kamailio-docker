DISTS ?= trixie bookworm bullseye noble jammy

VERSION ?= 6.1.1

all: clean dockerfile docker-image

dockerfile: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done

docker-image:
	for i in $(DISTS) ; do \
		docker build -f $$i/Dockerfile -t kamailio-$$i:$(VERSION) -t kamailio-$(VERSION):$$i; \
	done

clean:
	rm -rf $(DISTS)/*
