# This is the default Clever Wag Makefile.
# Please do not alter this file directly.
WAG_MK_VERSION := 0.2.1
SHELL := /bin/bash
SYSTEM := $(shell uname -a | cut -d" " -f1 | tr '[:upper:]' '[:lower:]')
WAG_INSTALLED := $(shell [[ -e "bin/wag" ]] && bin/wag --version)
WAG_LATEST = $(shell curl -s https://api.github.com/repos/Clever/wag/releases/latest | grep tag_name | cut -d\" -f4)

.PHONY: bin/wag wag-update-makefile wag-generate-deps ensure-wag-version-set

ensure-wag-version-set:
	@ if [[ "$(WAG_VERSION)" = "" ]]; then \
		echo "WAG_VERSION not set in Makefile - Suggest setting 'WAG_VERSION := latest'"; \
		exit 1; \
	fi

bin/wag: ensure-wag-version-set
	@mkdir -p bin
	$(eval WAG_VERSION := $(if $(filter latest,$(WAG_VERSION)),$(WAG_LATEST),v$(WAG_VERSION)))
	@echo "Checking for wag updates..."
	@echo "Using wag version $(WAG_VERSION)"
	@[[ "$(WAG_VERSION)" != "v$(WAG_INSTALLED)" ]] && echo "Updating wag..." && curl -sL https://github.com/Clever/wag/releases/download/$(WAG_VERSION)/wag-$(WAG_VERSION)-$(SYSTEM)-amd64.tar.gz | tar -xz -C bin || true

# wag-generate-deps installs all dependencies needed for wag generate.
wag-generate-deps: bin/wag

# wag-generate is a target for generating code from a swagger.yml using wag
# arg1: path to swagger.yml
# arg2: pkg path
define wag-generate
bin/wag -go-package $(2)/gen-go -js-path ./gen-js -file $(1)
go generate $(2)/gen-go/server $(2)/gen-go/client $(2)/gen-go/models
endef

wag-update-makefile:
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/wag.mk -O /tmp/wag.mk 2>/dev/null
	@if ! grep -q $(WAG_MK_VERSION) /tmp/wag.mk; then cp /tmp/wag.mk wag.mk && echo "wag.mk updated"; else echo "wag.mk is up-to-date"; fi
