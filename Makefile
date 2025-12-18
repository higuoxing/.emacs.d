DRONES_DIR = $(shell git config "borg.drones-directory" || echo "lib")
CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

INIT_FILES := $(CURRENT_DIR)/lisp/*.el

-include $(DRONES_DIR)/borg/borg.mk

bootstrap-borg:
	@git submodule--helper clone --name borg --path $(DRONES_DIR)/borg --url git@github.com:emacscollective/borg.git
	@cd $(DRONES_DIR)/borg; git symbolic-ref HEAD refs/heads/main
	@cd $(DRONES_DIR)/borg; git reset --hard HEAD

TREESIT_LANGUAGES := c cpp go python rust markdown markdown-inline

build-treesit-languages:
	@cd ~/.emacs.d/tree-sitter; INSTALL_DIR=~/.emacs.d/tree-sitter JOBS=$(shell nproc) ./batch.sh $(TREESIT_LANGUAGES)
