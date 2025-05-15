# This is the default Clever Golang Makefile.
# It is stored in the dev-handbook repo, github.com/Clever/dev-handbook
# Please do not alter this file directly.
#
# Version 2 is intended to be used with the new Clever CI system, and
# will not work with pre-orb scripting.
GOLANG_MK_VERSION := 2.0.0

SHELL := /bin/bash
SYSTEM := $(shell uname -a | cut -d" " -f1 | tr '[:upper:]' '[:lower:]')
.PHONY:

# set timezone to UTC for golang to match circle and deploys
export TZ=UTC

# go build flags for use across all commands which accept them
export GOFLAGS := -mod=vendor $(GOFLAGS)

# if the gopath includes several directories, use only the first
GOPATH=$(shell echo $$GOPATH | cut -d: -f1)

# This block checks and confirms that the proper Go toolchain version is installed.
# It uses ^ matching in the semver sense -- you can be ahead by a minor
# version, but not a major version (patch is ignored).
# arg1: golang version
define golang-version-check
_ := $(if  \
		$(shell  \
			expr >/dev/null  \
				`go version | cut -d" " -f3 | cut -c3- | cut -d. -f2 | sed -E 's/beta[0-9]+//'`  \
				\>= `echo $(1) | cut -d. -f2`  \
				\&  \
				`go version | cut -d" " -f3 | cut -c3- | cut -d. -f1`  \
				= `echo $(1) | cut -d. -f1`  \
			&& echo 1),  \
		@echo "",  \
		$(error must be running Go version ^$(1) - you are running $(shell go version | cut -d" " -f3 | cut -c3-)))
endef

# golang-build: builds a golang binary
# arg1: pkg path
# arg2: executable name
define golang-build
@echo "BUILDING $(2)..."
@CGO_ENABLED=0 go build -o bin/$(2) $(1);
endef

# golang-debug-build: builds a golang binary with debugging capabilities
# arg1: pkg path
# arg2: executable name
define golang-debug-build
@echo "BUILDING $(2) FOR DEBUG..."
@CGO_ENABLED=0 go build -gcflags="all=-N -l" -o bin/$(2) $(1);
endef

# golang-cgo-build: builds a golang binary with CGO
# arg1: pkg path
# arg2: executable name
define golang-cgo-build
@echo "BUILDING $(2) WITH CGO ..."
@CGO_ENABLED=1 go build -installsuffix cgo -o bin/$(2) $(1);
endef

# golang-update-makefile downloads latest version of golang.mk
golang-update-makefile:
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/golang-v2.mk -O /tmp/golang.mk 2>/dev/null
	@if ! grep -q $(GOLANG_MK_VERSION) /tmp/golang.mk; then cp /tmp/golang.mk golang.mk && echo "golang.mk updated"; else echo "golang.mk is up-to-date"; fi
