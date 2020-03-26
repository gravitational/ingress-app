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
import: $(shell mkdir -p $(OUT_DIR)) check-vars
	-$(GRAVITY) app delete --force --insecure           \
		$(GRAVITY_EXTRA_FLAGS)                            \
		$(REPOSITORY)/$(NAME):$(VERSION)
	$(GRAVITY) app import --vendor --version=$(VERSION) \
		$(GRAVITY_IMAGE_FLAGS) $(GRAVITY_EXTRA_FLAGS)     \
		--ignore=resources/charts/ingress-nginx/docs      \
		--ignore=resources/charts/ingress-nginx/test      \
		--ignore=resources/charts/ingress-nginx/vendor    \
		--include=resources --include=registry .

.PHONY: version
version:
	@echo $(VERSION)

.PHONY: check-vars
check-vars:
	@if [ -z "$(VERSION)" ]; then \
		echo "VERSION is not set"; exit 1; \
	fi;

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)
