# This is the default Clever Swagger Makefile.
# Please do not alter this file directly.
SWAGGER_MK_VERSION := 0.4.1

SHELL := /bin/bash

GOSWAGGER := $(GOPATH)/bin/swagger
.PHONY: $(GOSWAGGER)
$(GOSWAGGER):
	go get -u github.com/go-swagger/go-swagger/cmd/swagger

SWAGGER_CODEGEN_CLI_IMAGE := clever/swagger-codegen\:latest
WAG_IMAGE := clever/wag\:latest

swagger-validate-deps: $(GOSWAGGER)

define swagger-validate
@echo "VALIDATING $(1)..."
@$(GOSWAGGER) validate $(1)
endef

swagger-generate-go-deps:
	docker pull $(WAG_IMAGE)

define swagger-generate-go
@echo "GENERATING GO SERVER AND CLIENT FROM $(1)"
@echo "    GOPATH WORKDIR PACKAGE NAME: $(2)"
@echo "    GENERATED PACKAGE NAME: $(3)"
docker run -v $(GOPATH)/src:/gopath/src -w /gopath/src/$(2) -i -t $(WAG_IMAGE) -file $(1) -package $(3)
sudo chown -R $(USER):$(USER) $(GOPATH)/src/$(3)
endef

swagger-generate-javascript-client-deps:
	docker pull $(SWAGGER_CODEGEN_CLI_IMAGE)

define swagger-generate-javascript-client
@echo "GENERATING JAVASCRIPT CLIENT FROM $(1)"
@echo "    NPM PACKAGE NAME: $(2)"
@echo "    NPM PACKAGE VERSION: $(3)"
@echo "    MODULE NAME: $(4)"
rm -rf gen-js
docker run -v `pwd`:/src -i -t $(SWAGGER_CODEGEN_CLI_IMAGE) \
  generate -i $(1) -l javascript -o gen-js \
  --additional-properties "usePromises=true,useTracing=true,projectName=$(2),projectVersion=$(3),moduleName=$(4)"
sudo chown -R $(USER):$(USER) gen-js
endef