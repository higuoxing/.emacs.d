CURRENT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
DEPS_DIR := $(CURRENT_DIR)/../
INSTALL_PREFIX := $(CURRENT_DIR)/../../dist

.PHONY: bootstrap
bootstrap: build-slang

.PHONY: build
build:
	@echo "Verilog: No target to build, skipping..."

.PHONY: build-slang
build-slang:
	@echo "==> Building slang and slang-server..."
	@mkdir -p $(DEPS_DIR) $(INSTALL_PREFIX)
	cd $(DEPS_DIR)/slang && cmake -B build -DCMAKE_INSTALL_PREFIX=$(INSTALL_PREFIX) -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(shell nproc) && cmake --install build
	cd $(DEPS_DIR)/slang-server && cmake -B build -DCMAKE_INSTALL_PREFIX=$(INSTALL_PREFIX) -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(shell nproc) && cmake --install build
	@echo "==> Slang server installed to $(INSTALL_PREFIX)/bin/slang-server"
