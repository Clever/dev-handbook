# This is the default Clever lambda Makefile.
# It is stored in the dev-handbook repo, github.com/Clever/dev-handbook
# Please do not alter this file directly.
LAMBDA_MK_VERSION := 0.3.0
SHELL := /bin/bash

GOPATH ?= $(HOME)/go

# lambda-build-go: builds a lambda function written in Go to run on Arm64 architecture
# arg1: pkg path
# arg2: executable name
define lambda-build-go
@GOOS=linux GOARCH=arm64 go build -o bin/$(2) $(1)
# provided.al2 requires executable to be named `boostrap`
# During migration include both `bootstrap` and `$(2)` in the
# zip file, and once everything is on al2, remove `$(2)`
@cp bin/$(2) bin/bootstrap
@(cd bin && zip $(2).zip $(2) bootstrap)
endef

# lambda-build-node: builds a lambda function written in Node
# arg1: app/repo name
define lambda-build-node
@echo 'Compiling...'
@node_modules/.bin/tsc --outDir bin/
@echo 'Prepping dependencies...'
@rm -r node_modules/
@npm install --quiet --production
@cp -r node_modules/ bin/node_modules/
@echo 'Copying kvconfig.yml...'	
@cp kvconfig.yml bin/kvconfig.yml
@echo 'Creating zip file...'
@(cd bin/ && zip -qr $(1).zip *)
@echo 'Restoring dev dependencies...'
@npm install --quiet
endef

# lambda-update-makefile updates this makefile.
define lambda-update-makefile
@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/lambda.mk -O /tmp/lambda.mk 2>/dev/null
@if ! grep -q $(LAMBDA_MK_VERSION) /tmp/lambda.mk; then cp /tmp/lambda.mk lambda.mk && echo "lambda.mk updated"; else echo "lambda.mk is up-to-date"; fi
endef
