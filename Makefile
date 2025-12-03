DRONES_DIR = $(shell git config "borg.drones-directory" || echo "lib")
CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

.PHONY: all
all: bootstrap-borg
	$(MAKE) -f $(DRONES_DIR)/borg/borg.mk

.PHONY: build borg-build
build: bootstrap-borg borg-build build-tree-sitter-module

tree-sitter/tree-sitter-module-build-done: build-tree-sitter-module
	touch tree-sitter/tree-sitter-module-build-done

build-tree-sitter-module:
	@echo ""
	@echo "--- [tree-sitter-module] ---"
ifneq ($(whildcard tree-sitter/tree-sitter-module-build-done),)
	@cd $(CURRENT_DIR)/lib/tree-sitter-module; INSTALL_DIR=$(CURRENT_DIR)/tree-sitter JOBS=$(shell nproc) ./batch.sh
else
	@echo "Skip building tree-sitter-module."
endif
	@echo ""

borg-build: bootstrap-borg
	$(MAKE) -f $(DRONES_DIR)/borg/borg.mk build

bootstrap-borg:
	@git submodule--helper clone --name borg --path $(DRONES_DIR)/borg --url git@github.com:emacscollective/borg.git
	@cd $(DRONES_DIR)/borg; git symbolic-ref HEAD refs/heads/main
	@cd $(DRONES_DIR)/borg; git reset --hard HEAD

.PHONY: clean tree-sitter-module-clean borg-clean
clean: tree-sitter-module-clean borg-clean

tree-sitter-module-clean:
	@rm -rf $(CURRENT_DIR)/tree-sitter

borg-clean:
	$(MAKE) -f $(DRONES_DIR)/borg/borg.mk clean

help helpall native quick redo:
	$(MAKE) -f $(DRONES_DIR)/borg/borg.mk $@
