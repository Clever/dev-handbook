# Style

This document explains the standards we have around code style in various different languages.
Style is important to standardize for a few reasons:

* Makes code more readable, and thus easier to understand.
* Avoids holy wars over small details, but still encourages an approach to coding that sweats the details.

For each of the languages below we link to a style guide reference and outline tools to use in order to help follow the style guide.
Making sure you follow these guidelines is at the same level of importance of making sure tests pass, so the tools outlined below should be part of the build and test cycle for every project.
Doing it as part of the build and test cycle (as opposed to elsewhere, e.g. git hooks) ensures that no code is merged into master that fails these checks and allows for maximum flexibility during development.
As a code reviewer, you should hold people accountable to following the style guide for the appropriate language.

## Tools

It is much easier to follow style rules when your editor displays feedback as you code. The following tools for each editor do just that for any language, provided that the linters for those languages are present on your system and configured properly.

### vim

[Syntastic](https://github.com/scrooloose/syntastic) triggers linters on save. Steps:

1. Follow the installation instructions on the README.
2. Ensure the linter you want to use is present. For instances, on Python you should have `pep8` installed on your system (you should be able to run it from the command line).
3. Add the corresponding syntastic linter invocation to your `.vimrc` file to activate that tool; for `pep8`, for example, it would be: `let g:syntastic_python_checkers=['pep8']`

You can add multiple linters for a language by adding more entries to the array corresponding to that language (they will be invoked in the order they are declared). Check the documentation for more settings by typing `:help syntastic` in vim.

### sublime

Sublime Linter ([2](https://github.com/SublimeLinter/SublimeLinter-for-ST2), [3](https://github.com/SublimeLinter/SublimeLinter3)) looks like a promising choice for linting as you code. TODO: someone who uses Sublime should try this out

### emacs

[Flycheck](https://github.com/flycheck/flycheck) looks like a promising choice for linting as you code in emacs. TODO: someone who uses emacs should try this out

## Language-specific linters

### Go

The style guide used for Go can be found on the [Golang On Clever](./golang/README.md) page.

### CoffeeScript

The style guide used for CoffeeScript can be found [here](https://github.com/Clever/coffeescript-style-guide). [coffeelint](https://github.com/clutchski/coffeelint) and [coffee-jshint](https://github.com/Clever/coffee-jshint) should be added as a test. The coffeelint config can be found [here](https://github.com/Clever/coffeescript-style-guide/blob/master/coffeelint-config.json).

### Python

The style guide we use is [PEP8](http://legacy.python.org/dev/peps/pep-0008/) with exceptions for allowing tab widths of two spaces and line lengths of up to 100.

#### Recommended setup

PEP8 has an accompanying command-line tool, `pep8` (`pip install pep8`) that accepts a config file, this should live at `~/.config/pep8`

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

### Bash

The [Google Shell Style Guide](https://google-styleguide.googlecode.com/svn/trunk/shell.xml) is what we follow for shell scripts.
There are no automated tools that we use for following this, however there is [ShellCheck](http://www.shellcheck.net/about.html) which covers some of what's in the style guide.
