EMACS ?= emacs
SHELL ?= bash
CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
TREESIT_LANGUAGES := c cpp go python rust markdown markdown-inline

.PHONY: bootstrap
bootstrap: build build-treesit-languages

.PHONY: build
build:
	$(EMACS) --batch -l init.el

.PHONY: build-treesit-languages
build-treesit-languages:
	@cd ~/.emacs.d/tree-sitter; INSTALL_DIR=~/.emacs.d/tree-sitter JOBS=$(shell nproc) ./batch.sh $(TREESIT_LANGUAGES)
