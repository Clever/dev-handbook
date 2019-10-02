# This is the default Clever lambda Makefile.
# It is stored in the dev-handbook repo, github.com/Clever/dev-handbook
# Please do not alter this file directly.
LAMBDA_MK_VERSION := 0.2.0
SHELL := /bin/bash

GOPATH ?= $(HOME)/go

# lambda-build-go: builds a lambda function written in Go
# arg1: pkg path
# arg2: executable name
define lambda-build-go
@GOOS=linux go build -o bin/$(2) $(1)
@(cd bin && zip $(2).zip $(2))
endef

# lambda-build-node: builds a lambda function written in Node
# arg1: handler file path (src/handler/index.ts)
# ark2: app/repo name
define lambda-build-node
@echo 'Compiling...'
@node_modules/.bin/tsc --outDir bin/ $(1)
@echo 'Prepping dependencies...'
@rm -r node_modules/
@npm install --quiet --production
@cp -r node_modules/ bin/node_modules/
@echo 'Creating zip file...'
@(cd bin/ && zip -qr $(2).zip index.js node_modules/)
@echo 'Restoring dev dependencies...'
@npm install --quiet
endef

# lambda-update-makefile updates this makefile.
define lambda-update-makefile
@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/lambda.mk -O /tmp/lambda.mk 2>/dev/null
@if ! grep -q $(LAMBDA_MK_VERSION) /tmp/lambda.mk; then cp /tmp/lambda.mk lambda.mk && echo "lambda.mk updated"; else echo "lambda.mk is up-to-date"; fi
endef
