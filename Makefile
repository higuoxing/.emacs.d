EMACS ?= emacs
SHELL ?= bash
CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
DEPS_DIR := $(CURRENT_DIR)deps
# Local install prefix so we don't pollute the system
INSTALL_PREFIX := $(CURRENT_DIR)dist
TREESIT_LANGUAGES := c cpp go python rust dockerfile markdown markdown-inline yaml

.PHONY: bootstrap
bootstrap: build build-treesit-languages

.PHONY: build
build:
	$(EMACS) --batch -l init.el

.PHONY: build-treesit-languages
build-treesit-languages:
	@cd ~/.emacs.d/tree-sitter; INSTALL_DIR=~/.emacs.d/tree-sitter JOBS=$(shell nproc) ./batch.sh $(TREESIT_LANGUAGES)

.PHONY: build-slang
build-slang:
	@echo "==> Building slang and slang-server..."
	@mkdir -p $(DEPS_DIR) $(INSTALL_PREFIX)
	@if [ ! -d "$(DEPS_DIR)/slang" ]; then \
		git clone --recursive https://github.com/MikePopoloski/slang.git $(DEPS_DIR)/slang; \
	fi
	cd $(DEPS_DIR)/slang && cmake -B build -DCMAKE_INSTALL_PREFIX=$(INSTALL_PREFIX) -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(shell nproc) && cmake --install build
	@if [ ! -d "$(DEPS_DIR)/slang-server" ]; then \
		git clone --recursive https://github.com/hudson-trading/slang-server.git $(DEPS_DIR)/slang-server; \
	fi
	cd $(DEPS_DIR)/slang-server && cmake -B build -DCMAKE_INSTALL_PREFIX=$(INSTALL_PREFIX) -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(shell nproc) && cmake --install build
	@echo "==> Slang server installed to $(INSTALL_PREFIX)/bin/slang-server"
