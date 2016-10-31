# This is the default Clever Wag Makefile.
# Please do not alter this file directly.
WAG_MK_VERSION := 0.1.0
SYSTEM := $(shell uname -a | cut -d" " -f1 | tr '[:upper:]' '[:lower:]')

SHELL := /bin/bash
.PHONY: wag-update-makefile wag-generate-deps

./wag:
	curl -L https://github.com/Clever/wag/releases/download/v$(WAG_VERSION)/wag-$(WAG_VERSION)-$(SYSTEM)-amd64.tar.gz | tar -xz


# wag-generate-deps installs all dependencies needed for wag generate.
wag-generate-deps: ./wag

# wag-generate is a target for generating code from a swagger.yml using wag
# arg1: path to swagger.yml
# arg2: pkg path
define wag-generate
./wag -go-package $(2)/gen-go -js-path ./gen-js -file $(1)
go generate $(2)/gen-go/server $(2)/gen-go/client $(2)/gen-go/models
endef

wag-update-makefile:
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/wag.mk -O /tmp/wag.mk 2>/dev/null
	@if ! grep -q $(WAG_MK_VERSION) /tmp/wag.mk; then cp /tmp/wag.mk wag.mk && echo "wag.mk updated"; else echo "wag.mk is up-to-date"; fi
