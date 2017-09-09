CASK ?= cask
EMACS ?= emacs
VERSION := $(shell EMACS=$(EMACS) $(CASK) version)

SRC = $(wildcard *.el)
PACKAGE = dist/flycheck-swift-$(VERSION).el

.PHONY: help all deps package install test clean

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

deps:
## Installs the dependencies.
	$(CASK) install

$(PACKAGE): $(SRC) ## no-doc
	rm -rf dist
	$(CASK) package

package: $(PACKAGE)
## Builds the package.

install: package
## Installs the package.
	$(CASK) exec $(EMACS) --batch \
	  -l package \
	  -f package-initialize \
	  --eval "(add-to-list 'package-archives '(\"melpa\" . \"http://melpa.org/packages/\") t)" \
	  -f package-refresh-contents \
	  --eval '(package-install-file "$(PACKAGE)")'

clean:
## Cleans the dist directory.
	rm -rf dist

test:
## Tests the package.
	$(CASK) exec $(EMACS) --batch -q \
	  --eval "(add-to-list 'load-path \""$(shell readlink -f .)"\")" \
	  -l test/flycheck-swift-test.el \
	  -f ert-run-tests-batch-and-exit
