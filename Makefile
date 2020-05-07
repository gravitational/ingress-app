REPOSITORY := gravitational.io
NAME := ingress-app
VERSION ?= $(shell git describe --tags)
OUT_DIR ?= $(shell pwd)/build
OUT ?= $(OUT_DIR)/$(NAME)-$(VERSION).tar.gz
GRAVITY ?= gravity

DEBIAN_VERSION := stretch

GRAVITY_EXTRA_FLAGS ?=
GRAVITY_IMAGE_FLAGS := --set-image=quay.io/gravitational/debian-tall:$(DEBIAN_VERSION)

.PHONY: tarball
tarball: check-vars import
	$(GRAVITY) package export \
		$(GRAVITY_EXTRA_FLAGS) \
		$(REPOSITORY)/$(NAME):$(VERSION) $(OUT)

.PHONY: import
import: check-vars | $(OUT_DIR)
	-$(GRAVITY) app delete --force --insecure           \
		$(GRAVITY_EXTRA_FLAGS)                            \
		$(REPOSITORY)/$(NAME):$(VERSION)
	$(GRAVITY) app import --vendor --version=$(VERSION) \
		$(GRAVITY_IMAGE_FLAGS) $(GRAVITY_EXTRA_FLAGS)     \
		--include=resources --include=registry .

$(OUT_DIR):
	mkdir -p $@

.PHONY: version
version:
	@echo $(VERSION)

.PHONY: check-vars
check-vars:
ifndef VERSION
	$(error VERSION is not set)
endif

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)
