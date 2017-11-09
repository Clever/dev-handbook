# Dep

`dep` is a prototype dependency management tool for Go.
`dep` is the official experiment, but not yet the official tool.

See the `dep` repo (https://github.com/golang/dep) for more information. Their FAQ (https://github.com/golang/dep/blob/master/docs/FAQ.md) is very informative.


## Makefile

We have callable make directives in `golang.mk` in version `^0.2.0`. These should be invoked in your local Makefile with:

```
install_deps: golang-dep-vendor-deps
	$(call golang-dep-vendor)
```

This will then be invoked locally with `make install_deps`. It will do the following:
- pull down all dependencies
- update `Gopkg.toml` if you have added a dependency


## New Packages

Access the local copy of `dep` in `./bin/dep`. If it isn't there, run `make bin/dep`.
Then you can:

```
./bin/dep ensure -add github.com/foo/bar
```


## Update Every Package

```
./bin/dep ensure -update
```


## Updating A Single Package

If you need to pull in the updates for a single project

```
./bin/dep ensure -update github.com/another/project
```

If you have constraints in place in `Gopkg.toml`, it will pull down the latest version that it can.


## Removing A Dependency

1. Remove the imports and all usage from your code.
2. Remove [[constraint]] rules from Gopkg.toml (if any).
3. Run:

```
./bin/dep ensure
```

## My Build Timed Out?

Do you have output like this?

```
make install_deps
Updating dep...
bin/dep ensure

command make install_deps took more than 10 minutes since last output
```

This is usually due to missing SSH access to github private repos.
See the docs on confluence for the Build System to remedy the situation.


