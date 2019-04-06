DISTS:=stretch jessie wheezy precise trusty xenial
VERSION:=5.0.8

all: clean
	for i in $(DISTS) ; do \
		./create_dockerfile.sh $$i $(VERSION); \
	done
clean:
	rm -rf $(DISTS)
