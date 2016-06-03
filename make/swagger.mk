# This is the default Clever Swagger Makefile.
# Please do not alter this file directly.
SWAGGER_MK_VERSION := 0.3.0

SHELL := /bin/bash

GOSWAGGER := $(GOPATH)/bin/swagger
.PHONY: $(GOSWAGGER)
$(GOSWAGGER):
	go get -u github.com/go-swagger/go-swagger/cmd/swagger

SWAGGER_CODEGEN_CLI := swagger-codegen-cli.jar
$(SWAGGER_CODEGEN_CLI):
	wget http://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.1.6/swagger-codegen-cli-2.1.6.jar -O swagger-codegen-cli.jar

swagger-validate-deps: $(GOSWAGGER)

define swagger-validate
@echo "VALIDATING $(1)..."
@$(GOSWAGGER) validate $(1)
endef

swagger-generate-go-server-deps: $(GOSWAGGER)

define swagger-generate-go-server
@echo "GENERATING GO SERVER FROM $(1)..."
@$(GOSWAGGER) generate server -f $(1)
endef

swagger-generate-go-client-deps: $(GOSWAGGER)

define swagger-generate-go-client
@echo "GENERATING GO CLIENT FROM $(1)"
rm -rf gen-go
$(GOSWAGGER) generate client -f $(1) -t gen-go
endef

swagger-generate-javascript-client-deps: $(SWAGGER_CODEGEN_CLI)
define swagger-generate-javascript-client
@echo "GENERATING JAVASCRIPT CLIENT FROM $(1)"
@echo "    NPM PACKAGE NAME: $(2)"
@echo "    NPM PACKAGE VERSION: $(3)"
@echo "    MODULE NAME: $(4)"
rm -rf gen-js
python -c 'import json; print(json.dumps({"projectName":"$(2)","projectVersion":"$(3)","moduleName":"$(4)"}, indent=2))' > gen-js.json
java -jar $(SWAGGER_CODEGEN_CLI) generate -c gen-js.json -i $(1) -l javascript -o gen-js
endef
