# This is the default Clever Thrift Makefile.
# Please do not alter this file directly.

# thrift-all generates client code for Python, Golang and Nodejs.
define thrift-all
$(call thrift-python,$(1))
$(call thrift-go,$(1))
$(call thrift-nodejs,$(1))
endef

# Custom out directory specified since python doesn't like
# hyphens in package names
THRIFT_PYTHON_FLAGS ?= py:new_style --out genpy
define thrift-python
thrift -r --gen $(THRIFT_PYTHON_FLAGS) $(1)
endef

# github mirror is faster than the default
THRIFT_GO_FLAGS ?= go:thrift_import="github.com/apache/thrift/lib/go/thrift"
define thrift-go
thrift -r --gen $(THRIFT_GO_FLAGS) $(1)
endef

THRIFT_NODEJS_FLAGS ?= js:node
define thrift-nodejs
thrift -r --gen $(THRIFT_NODEJS_FLAGS) $(1)
endef

define thrift-verify-gen-code
$(call thrift-all,$(1))
$(if \
	$(shell git status gen-go genpy gen-nodejs -s), \
	@echo thrift client code must match thrift definition && exit 1,
	@echo thrift client code up to date)
endef

define thrift-bump-version
  (cd ./gen-nodejs; npm version $(1) | cut -c2- > ../VERSION)
endef

define thrift-versioning
thrift-bump-patch:
	$(call thrift-bump-version, patch)
thrift-bump-minor:
	$(call thrift-bump-version, minor)
thrift-bump-major:
	$(call thrift-bump-version, major)
endef
