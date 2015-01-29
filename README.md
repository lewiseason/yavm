# YAVM: Yet Another Version Manager

[![Gem Version](https://badge.fury.io/rb/YAVM.svg)](http://badge.fury.io/rb/YAVM)
[![Build Status](https://travis-ci.org/lewiseason/yavm.svg?branch=master)](https://travis-ci.org/lewiseason/yavm)

A tiny gem for managing project version numbers.

Heavily inspired by the `semver` gem, this is a tiny utility for managing version numbers,
which includes support for multiple version format stores:

* The `semver` gem's `.semver` file
* node.js `package.json` files
* bower `bower.json` files
* ruby `.gemspec` files

With planned support for:

* Python distutils package
* Possibly gem `::Version`

# Usage

*Exhaustive usage patterns can be found at `version help`*

``` shell
# Install
$ gem install yavm

# In a language/framework without a supported versioning system:
$ version init
$ version                # => 0.0.0

# In an existing project with supported versioning:
version                  # => 0.2.0

# Basic Usage
$ version inc minor      # => 0.3.0
$ version inc major      # => 1.0.0
$ version special pre4   # => 1.0.0-pre4
$ version special        # => 1.0.0
$ version meta 20141113  # => 1.0.0            (meta not displayed by default)
$ version tag            # => v1.0.0+20141113  (useful for version control)
$ version format "%M.%m" # => 1.0
```

## Available Format Tags

Tag | Meaning
----|---------------------
%M  | **M**ajor
%m  | **M**inor
%p  | **P**atch
%s  | **S**pecial
%t  | Me**t**a
%%  | Literal % Character

## Conflict Resolution

If your project contains multiple supported version "stores", YAVM will keep them in sync.
If they go out of sync outside of YAVM, you will be prompted to pick the canonical/authoritative
version, and all other stores will be updated.

``` text
$ version
Multiple version stores are in use, and aren't consistent.
  Please select the authoritative version:

WARNING: File munging is dangerous. A manual resolution might be safer.

     1: 1.0.0           [.semver file]
     2: 1.0.3           [bower.json file]
     3: 0.0.0           [gemspec: ./yavm.gemspec]

Selection: 2
Now on 1.0.3
```

# Roadmap

## Features

- [x] show version
- [x] increment
- [x] set special
- [x] set meta
- [x] formatting
- [x] tags
- [x] help
- [x] package.json support
- [x] bower.json support
- [x] when changing version, show new one
- [ ] programmatic interface
- [ ] tests
- [ ] handle invalid version info (see Version#parse)
- [x] 'version init'
- [ ] quick mode (when finding versions - short circuit once one is found)
- [ ] raise sensible exceptions
