CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
TREESIT_LANGUAGES := c cpp go python rust markdown markdown-inline

build-treesit-languages:
	@cd ~/.emacs.d/tree-sitter; INSTALL_DIR=~/.emacs.d/tree-sitter JOBS=$(shell nproc) ./batch.sh $(TREESIT_LANGUAGES)
