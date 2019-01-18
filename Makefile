DISTS ?= buster jessie stretch wheezy bionic precise trusty xenial

VERSION ?= 5.2.1

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
