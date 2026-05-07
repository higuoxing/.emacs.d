CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
INSTALL_PREFIX := $(CURRENT_DIR)/../../dist

.PHONY: bootstrap
bootstrap: build-slang-server

.PHONY: build
build:
	@echo "Verilog: No target to build, skipping..."

.PHONY: build-slang-server
build-slang-server:
	@echo "==> Building slang-server (slang is bundled as external/slang)..."
	@mkdir -p $(INSTALL_PREFIX)
	cd $(CURRENT_DIR)/slang-server && git submodule update --init --recursive
	cd $(CURRENT_DIR)/slang-server && cmake -B build -DCMAKE_INSTALL_PREFIX=$(INSTALL_PREFIX) -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(shell nproc) && cmake --install build
	@echo "==> Slang server installed to $(INSTALL_PREFIX)/bin/slang_server"
