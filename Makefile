EMACS ?= emacs
SHELL ?= bash
CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
# Local install prefix so we don't pollute the system
INSTALL_PREFIX := $(CURRENT_DIR)dist
TREESIT_LANGUAGES := c cpp go python rust dockerfile markdown markdown-inline yaml

.PHONY: bootstrap
bootstrap: build-init build-treesit-languages
	$(MAKE) -C deps bootstrap

.PHONY: build build-init build-deps
build: build-init build-deps

build-init:
	$(EMACS) --batch -l init.el

build-deps:
	$(MAKE) -C deps build

.PHONY: build-treesit-languages
build-treesit-languages:
	@cd ~/.emacs.d/tree-sitter; INSTALL_DIR=~/.emacs.d/tree-sitter JOBS=$(shell nproc) ./batch.sh $(TREESIT_LANGUAGES)
