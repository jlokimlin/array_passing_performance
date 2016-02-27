include make.inc

all: 
	mkdir -p ./lib
	mkdir -p ./objs
	cd ./src; $(MAKE) run

.PHONY: all