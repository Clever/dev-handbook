# Style

This document explains the standards we have around code style in various different languages.
Style is important to standardize for a few reasons:

* Makes code more readable, and thus easier to understand.
* Avoids holy wars over small details, but still encourages an approach to coding that sweats the details.

For each of the languages below we link to a style guide reference and outline tools to use in order to help follow the style guide.
These tools should be part of every project's build and test cycle.
As a code reviewer, you should hold people accountable to following the style guide for the appropriate language.

## Go

The style guides used for Go are [Effective Go](http://golang.org/doc/effective_go.html) and the community [Go style guide](https://code.google.com/p/go-wiki/wiki/CodeReviewComments). There are two tools that can be used to detect common mistakes.

* `go fmt` should be run in any directory that contains go files. It will automatically format the code.
* `golint file.go` should be run for every go file. It will lint the code and return any issues it finds.

### Recommended setups

* Makefiles: A Go package should have a Makefile that runs "golint" on all files, e.g.

    ```Makefile
    $(PKG):
    ifeq ($(LINT),1)
    	golint $(GOPATH)/src/$@*/**.go
    endif
    go test
    ...
    ```
    See [clever-go](https://github.com/Clever/clever-go/blob/master/Makefile) for an example.
* emacs
* sublime: Add [GoSublime](https://github.com/DisposaBoy/GoSublime) for code highlighting and `go fmt` on save.
* vim

## CoffeeScript

## Python

## Bash

The [Google Shell Style Guide](https://google-styleguide.googlecode.com/svn/trunk/shell.xml) is what we follow for shell scripts.
There are no automated tools that we use for following this, however there is [ShellCheck](http://www.shellcheck.net/about.html) which covers some of what's in the style guide.