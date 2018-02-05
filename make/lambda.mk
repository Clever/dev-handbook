# This is the default Clever lambda Makefile.
# It is stored in the dev-handbook repo, github.com/Clever/dev-handbook
# Please do not alter this file directly.
LAMBDA_MK_VERSION := 0.1.0
SHELL := /bin/bash

GOPATH ?= $(HOME)/go

# lambda-build-go: builds a lambda function written in Go
# arg1: pkg path
# arg2: executable name
define lambda-build-go
GOOS=linux go build -o bin/$(2) $(1)
(cd bin && zip $(2).zip $(2))
endef

# lambda-update-makefile updates this makefile.
define lambda-update-makefile
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/lambda.mk -O /tmp/lambda.mk 2>/dev/null
	@if ! grep -q $(LAMBDA_MK_VERSION) /tmp/lambda.mk; then cp /tmp/lambda.mk lambda.mk && echo "lambda.mk updated"; else echo "lambda.mk is up-to-date"; fi
endef
