[![License GPL 3][badge-license]][copying]

# flycheck-swift

Flycheck extension for Apple's Swift programming language.

## Installation

### Using MELPA

Coming soon.

### Manual installation

Install [Flycheck](http://www.flycheck.org/en/latest/user/installation.html).

```
git clone --depth 1 https://github.com/swift-emacs/flycheck-swift.git
cd flycheck-swift
emacs --batch -l package -f package-initialize --eval '(package-install-file "flycheck-swift.el")'
```

Add the following line to the `~/.emacs.d/init.el` or `~/.emacs`.

```
(eval-after-load 'flycheck '(flycheck-swift-setup))
```

### Using cask (for developer)

Install [cask](https://github.com/cask/cask).

```
git clone https://github.com/swift-emacs/flycheck-swift.git
cd flycheck-swift
make install
```

Add the following line to the `~/.emacs.d/init.el` or `~/.emacs`.

```
(eval-after-load 'flycheck '(flycheck-swift-setup))
```

## Customization

### flycheck-swift-executable

The name of the executable, i.e. `swiftc`.

### flycheck-swift-extra-flags

Extra flags prepended to arguments of swiftc.

### flycheck-swift-sdk-path

A path to the targeted SDK.

### flycheck-swift-linked-sources

A list of source file paths to link against. Each path can be glob, i.e. `*.swift`.

### flycheck-swift-framework-search-paths

A list of framework search paths.

### flycheck-swift-cc-include-search-paths

A list of include file search paths to pass to the Objective-C compiler.

### flycheck-swift-target

Target used by swift compiler.

### flycheck-swift-import-objc-header

Objective C header file to import.

## License

GPLv3. See [COPYING][] for details. Copyright (C) 2014-2016 taku0, Chris Barrett, Bozhidar Batsov, Arthur Evstifeev.

[badge-license]: https://img.shields.io/badge/license-GPL_3-green.svg
[COPYING]: ./COPYING
