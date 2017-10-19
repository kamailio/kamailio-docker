DISTS:=jessie wheezy squeeze precise trusty xenial
VERSION:=4.4.6

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
