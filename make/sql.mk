# This is the default Clever SQL Makefile.
# It is stored in the dev-handbook repo, github.com/Clever/dev-handbook
# Please do not alter this file directly.
SQL_MK_VERSION := 0.0.3

# USAGE:
# - safesql
#   safesql is a static analysis tool for Go that checks for vulnerability to SQL injections.
#   In your project's Makefile, call run-safesql. Example:
# 	```
# 	PKG = github.com/Clever/$(APP_NAME)
#
# 	safesql:
# 		$(call run-safesql,$(PKG))
# 	```
# 	Running make safesql will show "SCANNING SQL" and then the output of the safesql tool.

SHELL := /bin/bash
.PHONY: run-safesql sql-update-makefile

# if the gopath includes several directories, use only the first
GOPATH=$(shell echo $$GOPATH | cut -d: -f1)

# run-safesql runs safesql on the pkg
# arg1: pkg path
define run-safesql
@go get github.com/stripe/safesql
@echo ""
@echo "SCANNING SQL $(1)..."
$(GOPATH)/bin/safesql $(1)
endef

# sql-update-makefile downloads latest version of sql.mk
sql-update-makefile:
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/sql.mk -O /tmp/sql.mk 2>/dev/null
	@if ! grep -q $(SQL_MK_VERSION) /tmp/sql.mk; then cp /tmp/sql.mk sql.mk && echo "sql.mk updated"; else echo "sql.mk is up-to-date"; fi
