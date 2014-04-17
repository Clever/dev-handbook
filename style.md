# Style

This document explains the standards we have around code style in various different languages.
Style is important to standardize for a few reasons:

* Makes code more readable, and thus easier to understand.
* Avoids holy wars over small details, but still encourages an approach to coding that sweats the details.

For each of the languages below we link to a style guide reference and outline tools to use in order to help follow the style guide.
Making sure you follow these guidelines is at the same level of importance of making sure tests pass, so the tools outlined below should be part of the build and test cycle for every project.
Doing it as part of the build and test cycle (as opposed to elsewhere, e.g. git hooks) ensures that no code is merged into master that fails these checks and allows for maximum flexibility during development.
As a code reviewer, you should hold people accountable to following the style guide for the appropriate language.

## Go

The style guides used for Go are [Effective Go](http://golang.org/doc/effective_go.html) and the community [Go style guide](https://code.google.com/p/go-wiki/wiki/CodeReviewComments). There are two tools that can be used to detect common mistakes.

* `go fmt` should be run in any directory that contains go files. It will automatically format the code.
* `golint file.go` should be run for every go file. It will lint the code and return any issues it finds.

### Recommended setup

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
* emacs: Go has an official [emacs mode](http://golang.org/misc/emacs/go-mode.el) that ships with a `gofmt` command. To get it to run on save, you can add this to your `.emacs`:

    ```
    (add-hook 'before-save-hook 'gofmt-before-save)
    ```

* sublime: Add [GoSublime](https://github.com/DisposaBoy/GoSublime) for code highlighting and `go fmt` on save.

* vim: See the directions [here](http://tip.golang.org/misc/vim/readme.txt). It's strongly advised to set up `gofmt` on save.

## CoffeeScript

The style guide used for CoffeeScript can be found [here](https://github.com/Clever/coffeescript-style-guide). [coffeelint](https://github.com/clutchski/coffeelint) should be added as a test. The coffeelint config can be found [here](https://github.com/Clever/coffeescript-style-guide/blob/master/coffeelint-config.json).

## Python

The style guide we use is [PEP8](http://legacy.python.org/dev/peps/pep-0008/) with exceptions for allowing tab widths of two spaces and line lengths of up to 100.

### Recommended setup

PEP8 has an accompanying command-line tool, `pep8` (`pip install pep8`) that accepts a config file:

```
[pep8]
ignore = E111
max-line-length = 100
```

There is also the tool `autopep8` (`pip install autopep8`) that will fix all the problems found by `pep8`.

* emacs: You can run `autopep8` on save by installing [`py-autopep8`](https://github.com/paetzke/py-autopep8.el) and adding the following to your `.emacs`:

    ```Makefile
    (add-hook 'before-save-hook 'py-autopep8-before-save)
    (setq py-autopep8-options '("--max-line-length=100" "--indent-size=2"))
    ```

* vim: https://github.com/tell-k/vim-autopep8

* sublime: https://github.com/wistful/SublimeAutoPEP8

## Bash

The [Google Shell Style Guide](https://google-styleguide.googlecode.com/svn/trunk/shell.xml) is what we follow for shell scripts.
There are no automated tools that we use for following this, however there is [ShellCheck](http://www.shellcheck.net/about.html) which covers some of what's in the style guide.