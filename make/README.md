# Make

This is intended to host our Makefile "libraries."
The intention is to allow mass updating of all golang/thrift/etc specific rules without manually editing each Makefile.

All rules and definitions are namespaced with their filename.
I.e. all names in golang.mk start with `golang-`.

All definitions should have a `-deps` target to ensure that the dependencies are ready.
I.e. `foo-bar` in foo.mk should have a `foo-bar-deps` target.


## make meta-programming

This takes advantage of several less commonly used make features

- [the `include` directive](http://www.gnu.org/software/make/manual/make.html#Include)
- [the `define` directive](http://www.gnu.org/software/make/manual/make.html#Multi_002dLine)
- [the `eval` function](http://www.gnu.org/software/make/manual/make.html#Eval-Function)

[This blog post](http://make.mad-scientist.net/the-eval-function/) provides a nice overview of how these can all be leveraged together.


## Golang

See the [gearcmd Makefile](https://github.com/Clever/gearcmd/blob/master/Makefile) as an example.

- toolchain version check
- godep
- testing
  - gofmt
  - golint
  - go vet
  - go test

## Node

- node version check

Example Makefile using `node.mk`

```make
include node.mk
.DEFAULT_GOAL := test

COFFEE_FILE_COUNT := 11
NODE_VERSION := v6

$(eval $(call node-version-check,$(NODE_VERSION)))
check-coffee-file-count:
  $(call node-coffeescript-file-count-check,$(COFFEE_FILE_COUNT))

run:
  NODE_ENV=development node_modules/node-dev/bin/node-dev server.coffee
```

## Thrift

- thrift generate
  - golang
  - node
  - python
- verification of up-to-date client code
- bump minor/major/patch versions

## Swagger

- validate swagger spec
- generate Go server
- generate Go client
- generate Javascript client


Here's an example `Makefile` that includes `swagger.mk`.
It allows validating a Swagger spec and generating corresponding code.

```make
include swagger.mk

SWAGGER_CONFIG := swagger.yaml
SWAGGER_CLIENT_NPM_PACKAGE := @clever/my-package

# validate spec described in SWAGGER_CONFIG
swagger-validate: swagger-validate-deps
	$(call swagger-validate,$(SWAGGER_CONFIG))

# generate a Go server, Go client, Node client, based on spec in SWAGGER_CONFIG
swagger-generate: validate swagger-generate-go-server-deps swagger-generate-javascript-client-deps swagger-generate-go-client-deps
	$(call swagger-generate-go-server,$(SWAGGER_CONFIG))
	$(call swagger-generate-javascript-client,$(SWAGGER_CONFIG),$(SWAGGER_CLIENT_NPM_PACKAGE),$(VERSION))
	$(call swagger-generate-go-client,$(SWAGGER_CONFIG))
```

# SQL

- install and run safesql (a Golang SQL injection checking tool)

Safesql provides an option to ignore a line or query. If you plan to ignore a safesql failure, discuss it with security before release. 
