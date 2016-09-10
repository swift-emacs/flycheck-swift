CASK ?= cask
EMACS ?= emacs
VERSION := $(shell EMACS=$(EMACS) $(CASK) version)

SRC = $(wildcard *.el)
PACKAGE = dist/flycheck-swift-$(VERSION).el

.PHONY: help all cask-install package install test clean

help:
## Shows this message.
# Process this Makefile with following filters
#
# - Remove empty line.
# - Remove lien containing ## no-doc.
# - Remove after colon if the line is not a comment line.
# - Replace /^## / to "  ".
# - Remove other comment lines.
# - Insert newline before rules.
	@sed -e '/^\s*$$/d; /^[	.A-Z]/d; /## no-doc/d; s/^\([^#][^:]*\):.*/\1/; s/^## /  /; /^#/d; s/^[^ ]/\n&/' Makefile

all: package
## Builds the package.

cask-install:
## Installs the dependencies.
	$(CASK) install

$(PACKAGE): $(SRC) ## no-doc
	$(MAKE) cask-install
	rm -rf dist
	$(CASK) package

package: $(PACKAGE)
## Builds the package.

install: package
## Installs the package.
	$(CASK) exec $(EMACS) --batch \
	  -l package \
	  -f package-initialize \
	  --eval '(package-install-file "$(PACKAGE)")'

clean:
## Cleans the dist directory.
	rm -rf dist

test: package
## Tests the package.
	$(CASK) exec $(EMACS) --batch \
	  -l $(PACKAGE) \
	  -l test/flycheck-swift-test.el \
	  -f ert-run-tests-batch-and-exit
