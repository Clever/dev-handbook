# This is the default Clever Wag Makefile.	
# Please do not alter this file directly.
WAG_MK_VERSION := 0.6.1
SHELL := /bin/bash
SYSTEM := $(shell uname -a | cut -d" " -f1 | tr '[:upper:]' '[:lower:]')
ifndef CI
WAG_INSTALLED := $(shell [[ -e "bin/wag" ]] && bin/wag --version)
WAG_LATEST = $(shell curl --retry 5 -f -s https://api.github.com/repos/Clever/wag/releases/latest | grep tag_name | cut -d\" -f4)
endif
.PHONY: wag-update-makefile ensure-wag-version-set wag-generate-deps

# identify path to jsdoc2md which makes it a file target
VPATH = node_modules/.bin

ifndef CI
ensure-wag-version-set:
	@ if [[ "$(WAG_VERSION)" = "" ]]; then \
		echo "WAG_VERSION not set in Makefile - Suggest setting 'WAG_VERSION := latest'"; \
		exit 1; \
	fi

bin/wag: ensure-wag-version-set
	@mkdir -p bin
	$(eval WAG_VERSION := $(if $(filter latest,$(WAG_VERSION)),$(WAG_LATEST),$(WAG_VERSION)))
	@echo "Checking for wag updates..."
	@echo "Using wag version $(WAG_INSTALLED)"
	@if [[ "$(WAG_VERSION)" != "$(WAG_INSTALLED)" ]]; \
		then \
			echo "Updating wag...to $(WAG_VERSION)"  && wget -P bin https://github.com/Clever/wag/releases/download/$(WAG_VERSION)/wag-$(WAG_VERSION)-$(SYSTEM)-amd64.tar.gz ; \
		fi;
	@if [ -a bin/wag-$(WAG_VERSION)-$(SYSTEM)-amd64.tar.gz ] ; \
		then \
			tar xvf bin/wag-$(WAG_VERSION)-$(SYSTEM)-amd64.tar.gz -C bin;\
			rm bin/wag-$(WAG_VERSION)-$(SYSTEM)-amd64.tar.gz ; \
		fi;

	@[[ "$(WAG_VERSION)" != "$(WAG_INSTALLED)" ]] && touch swagger.yml || true
jsdoc2md:
	hash npm 2>/dev/null || (echo "Could not run npm, please install node" && false)
	test -f ./node_modules/.bin/jsdoc2md || npm install jsdoc-to-markdown@^4.0.0

# wag-generate-deps installs all dependencies needed for wag generate.
wag-generate-deps: bin/wag jsdoc2md
else
ensure-wag-version-set:
bin/wag:
jsdoc2md:
endif

# wag-yaml-aliases generate code workaround to use YAML aliases in swagger.yml for modules repos
# wag parses the file into go-yaml's MapSlice, which does not handle out of order aliases: https://github.com/go-yaml/yaml/issues/438
# arg1: path to swagger.yml
define wag-yaml-aliases
@if [ -z "$$CI" ]; then \
	cat $(1) | python3 -c "import sys, yaml, json; y=yaml.load(sys.stdin.read(), yaml.Loader); print(yaml.dump(y))" > /tmp/swagger.catapult.yml; \
	bin/wag -output-path ./gen-go -js-path ./gen-js -file /tmp/swagger.catapult.yml; \
	(cd ./gen-js && ../node_modules/.bin/jsdoc2md index.js types.js > ./README.md); \
else \
	echo "skipping wag-yaml-aliases in CI"; \
fi;
endef

# wag-generate is a target for generating code from a swagger.yml using wag
# arg1: path to swagger.yml
# arg2: pkg path
define wag-generate
@if [ -z "$$CI" ]; then \
    bin/wag -go-package $(2)/gen-go -js-path ./gen-js -file $(1); \
    (cd ./gen-js && ../node_modules/.bin/jsdoc2md index.js types.js > ./README.md); \
else \
	echo "skipping wag-generate in CI"; \
fi;
endef

# wag-generate-mod is a target for generating code from a swagger.yml using wag for modules repos
# arg1: path to swagger.yml
define wag-generate-mod
@if [ -z "$$CI"]; then \
    bin/wag -output-path ./gen-go -js-path ./gen-js -file $(1); \
    (cd ./gen-js && ../node_modules/.bin/jsdoc2md index.js types.js > ./README.md); \
else \

    echo "skipping wag-generate-mod in CI"; \
fi;
endef

wag-update-makefile:
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/wag.mk -O /tmp/wag.mk 2>/dev/null
	@if ! grep -q $(WAG_MK_VERSION) /tmp/wag.mk; then cp /tmp/wag.mk wag.mk && echo "wag.mk updated"; else echo "wag.mk is up-to-date"; fi
