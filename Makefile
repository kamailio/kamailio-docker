DISTS ?= buster jessie stretch wheezy bionic precise trusty xenial

VERSION ?= 5.3.5

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
