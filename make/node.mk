# This is the default Clever Node Makefile.
# Please do not alter this file directly.
NODE_MK_VERSION := 0.1.1

# This block checks and confirms that the proper node version is installed.
# arg1: node version. e.g. v6
define node-version-check
_ := $(if \
	$(shell node -v | grep $(1)), \
	@echo "", \
	$(error "Node $(1) is required, use nvm to install / use node it"))
endef
