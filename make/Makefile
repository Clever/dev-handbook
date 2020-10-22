include golang.mk
.DEFAULT_GOAL := test # override default goal set in library makefile

.PHONY: all test build release $(PKGS) bindata-kvconfig install_deps
SHELL := /bin/bash
export PATH := $(PWD)/bin:$(PATH)
PKGS := $(shell go list ./... | grep -v vendor | grep -v tools)
PKGS_NO_V := $(shell echo $(PKGS) | sed -E 's@(github.com/Clever/[a-z-]*)/v[0-9]@\1@g' | sed s@//@/@g)
RAWVERSION :=$(shell head -n 1 VERSION)
VERSION := $(RAWVERSION)$(shell if [[ -z "$(CI)" ]]; then echo "-dev"; fi)
DOCVERSION := $(shell head -n 3 docs/ark.md | tail -n 1 | grep -o "v[0-9]\+.[0-9]\+.[0-9]\+")
EXECUTABLE := ark
$(eval $(call golang-version-check,1.13))

all: test build release

# test: generate $(PKGS)
# 	@if [ $(RAWVERSION) != $(DOCVERSION) ]; then \
# 	echo -e "Docs are of date, \`make docs\` to update"; \
# 	exit 1; \
# 	fi
# 	@echo -e "\nAll done."

test: $(PKGS)

$(PKGS): golang-test-all-deps
#	$(call golang-fmt,$@)
	$(call golang-test-all,$@)

generate:
	go generate ./cmd
	go generate ./cmd/db
	go generate ./cmd/db/templates
	go generate ./vendor/github.com/Clever/catapult/gen-go/client/interface.go
	go generate ./vendor/github.com/Clever/init-service/gen-go/client/interface.go
	go generate ./lib/deployments/fetcher.go
	go generate ./lib/ark.go
	go generate ./lib/deployer.go
build: generate
	go build -ldflags=all="-X main.version=$(VERSION)" -o $(EXECUTABLE)

docs: generate
# write docs without the -dev suffix, then rebuild with the suffix
	go build -ldflags=all="-X main.version=$(RAWVERSION)" -o $(EXECUTABLE)
	./ark --no-upgrade docs
	go build -ldflags=all="-X main.version=$(VERSION)" -o $(EXECUTABLE)

release:
	@GOOS=linux GOARCH=amd64 go build -ldflags="-s -w -X main.version=$(VERSION)" \
		-o="$@/$(EXECUTABLE)-$(VERSION)-linux-amd64"
	@GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w -X main.version=$(VERSION)" \
		-o="$@/$(EXECUTABLE)-$(VERSION)-darwin-amd64"

install_deps:
	go mod vendor
	go build -o bin/go-bindata ./vendor/github.com/kevinburke/go-bindata/go-bindata
	go build -o bin/mockgen    ./vendor/github.com/golang/mock/mockgen
