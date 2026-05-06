SUBDIRS := $(wildcard */Makefile)
SUBDIRS := $(patsubst %/Makefile,%,$(SUBDIRS))

.PHONY: all build bootstrap $(SUBDIRS)

all: build

build: $(SUBDIRS:%=build-%)
bootstrap: $(SUBDIRS:%=bootstrap-%)

build-%:
	$(MAKE) -C $* build

bootstrap-%:
	$(MAKE) -C $* bootstrap
