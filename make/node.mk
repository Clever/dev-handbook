# This is the default Clever Node Makefile.
# Please do not alter this file directly.
NODE_MK_VERSION := 0.2.2

# This block checks and confirms that the proper node version is installed.
# arg1: node version. e.g. v6
define node-version-check
_ := $(if \
	$(shell node -v | grep $(1)), \
	@echo "", \
	$(error "Node $(1) is required, use nvm to install / use node it"))
endef

# This block checks and confirms the number of coffeescript files in the repo. The function must be
# called inside a target or it will result in a syntax error.
# arg1: number of coffeescript files. e.g. 10
define node-coffeescript-file-count-check
@echo -e "\nChecking count of coffeescript files"
@git ls-files '*.coffee' | wc -l | tr -d ' ' > /tmp/node-coffee-file-count
@if [ "`cat /tmp/node-coffee-file-count`" -eq "$(1)" ]; then \
	echo -e "\033[0;32m✓ No change in file count.\033[0m\n"; \
elif [ "`cat /tmp/node-coffee-file-count`" -gt "$(1)" ]; then \
	echo -e "\033[0;31m✖ Found new coffeescript file(s). All new modules should be written in ES6.\033[0m\n"; \
	exit 1; \
else \
	echo -e "\033[0;31m✖ Congrats! You have reduced the file count to `cat /tmp/node-coffee-file-count`. Please lower the expected count in the Makefile.\033[0m\n"; \
	exit 1; \
fi
endef

# node-update-makefile downloads latest version of node.mk
node-update-makefile:
	@wget https://raw.githubusercontent.com/Clever/dev-handbook/master/make/node.mk -O /tmp/node.mk 2>/dev/null
	@if ! grep -q $(NODE_MK_VERSION) /tmp/node.mk; then cp /tmp/node.mk node.mk && echo "node.mk updated"; else echo "node.mk is up-to-date"; fi
