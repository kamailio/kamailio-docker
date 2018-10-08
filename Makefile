DISTS ?= buster jessie stretch wheezy precise trusty xenial
VERSION ?= 5.1.6

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
